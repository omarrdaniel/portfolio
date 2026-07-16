terraform {
  required_version = ">= 1.7.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.41"
    }
  }

  # Remote state on Cloudflare R2 (S3-compatible API). The R2 bucket itself
  # is created once, manually, BEFORE the first `terraform init` — see
  # terraform/README.md "Bootstrap" section.
  #
  # access_key / secret_key are deliberately NOT set here. This is a
  # "partial" backend config: the R2 credentials are supplied at
  # `terraform init` time via -backend-config flags, sourced from
  # R2_ACCESS_KEY_ID / R2_SECRET_ACCESS_KEY (never named AWS_* anywhere
  # in this repo, even though the backend type is called "s3" — that's
  # just Terraform's generic name for any S3-compatible API).
  #
  # use_lockfile replaces the old DynamoDB-based locking: it uses a
  # conditional write (If-None-Match) against a lock object in the same
  # bucket. Requires Terraform >= 1.11; R2 supports conditional writes.
  backend "s3" {
    bucket                      = "omar-portfolio-tfstate"
    key                         = "terraform.tfstate"
    region                      = "auto"
    endpoints                   = { s3 = "https://<ACCOUNT_ID>.r2.cloudflarestorage.com" }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
    use_lockfile                = true
  }
}

provider "cloudflare" {
  # CLOUDFLARE_API_TOKEN read from environment — never hardcode it here.
}

# ── Zone ─────────────────────────────────────────────────────────────────────
# Assumes the domain is already added as a zone in Cloudflare (registered
# via Cloudflare Registrar or transferred in). Data source, not a resource,
# since the zone itself is created once, manually, during domain purchase.
data "cloudflare_zone" "this" {
  name = var.domain
}

# ── Cloudflare Pages project ────────────────────────────────────────────────
resource "cloudflare_pages_project" "portfolio" {
  account_id        = var.cloudflare_account_id
  name              = "omar-portfolio"
  production_branch = "main"

  build_config {
    build_command   = "npm run build"
    destination_dir = "dist"
    root_dir        = ""
  }

  deployment_configs {
    production {
      environment_variables = {
        NODE_VERSION = "20"
      }
    }
    preview {
      environment_variables = {
        NODE_VERSION = "20"
      }
    }
  }
}

# ── Custom domain binding ───────────────────────────────────────────────────
resource "cloudflare_pages_domain" "custom_domain" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.portfolio.name
  domain       = var.domain
}

resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.this.id
  name    = "@"
  type    = "CNAME"
  content = "${cloudflare_pages_project.portfolio.name}.pages.dev"
  proxied = true
  ttl     = 1 # required when proxied
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.this.id
  name    = "www"
  type    = "CNAME"
  content = var.domain
  proxied = true
  ttl     = 1
}

# ── WAF: custom rule set ────────────────────────────────────────────────────
# A small, deliberately visible ruleset — not meant to be exhaustive,
# but to show the pattern: WAF policy as reviewable, versioned code.
resource "cloudflare_ruleset" "waf_custom" {
  zone_id     = data.cloudflare_zone.this.id
  name        = "portfolio-waf-baseline"
  description = "Baseline WAF rules for the portfolio site"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression  = "(cf.threat_score gt 30)"
    description = "Block requests from IPs with an elevated Cloudflare threat score"
    enabled     = true
  }

  rules {
    action      = "challenge"
    expression  = "(not cf.client.bot) and (http.request.uri.path contains \"/projects/\") and (rate(1m) > 60)"
    description = "Challenge unusually high request rates against project pages"
    enabled     = true
  }
}

# ── Rate limiting on the root ───────────────────────────────────────────────
resource "cloudflare_rate_limit" "global" {
  zone_id   = data.cloudflare_zone.this.id
  threshold = 120
  period    = 60

  match {
    request {
      url_pattern = "${var.domain}/*"
      schemes     = ["HTTPS"]
      methods     = ["GET", "HEAD"]
    }
  }

  action {
    mode    = "challenge"
    timeout = 60
  }

  description = "Basic protection against scraping / traffic floods"
}

# ── Security-related zone settings ──────────────────────────────────────────
resource "cloudflare_zone_settings_override" "security" {
  zone_id = data.cloudflare_zone.this.id

  settings {
    ssl                      = "strict"
    always_use_https         = "on"
    min_tls_version          = "1.2"
    automatic_https_rewrites = "on"
    browser_check            = "on"
    security_level           = "medium"
  }
}
