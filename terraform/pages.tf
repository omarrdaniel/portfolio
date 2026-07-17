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
        NODE_VERSION = "24"
      }
    }
    preview {
      environment_variables = {
        NODE_VERSION = "24"
      }
    }
  }
}

resource "cloudflare_pages_domain" "custom_domain" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.portfolio.name
  domain       = var.domain
}
