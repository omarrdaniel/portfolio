# Infrastructure as Code — Cloudflare

Manages DNS, the Pages project, WAF rules, rate limiting and zone
security settings for the site — one resource type per file:

```
versions.tf       terraform block, provider requirements, backend
providers.tf       cloudflare provider
variables.tf
outputs.tf
zone.tf            zone data source
pages.tf           Pages project + custom domain
dns.tf             DNS records
waf.tf             WAF ruleset
rate_limit.tf
zone_settings.tf   TLS / SSL / security level
```

## Prerequisites

1. Domain registered and added as a zone in Cloudflare.
2. Cloudflare API Token scoped to:
   - `Zone.DNS: Edit`
   - `Zone.Zone Settings: Edit`
   - `Account.Cloudflare Pages: Edit`
   - `Zone.Firewall Services: Edit`

## Bootstrap: R2 state bucket (one-time)

The bucket has to exist before the first `terraform init`.

```bash
npx wrangler r2 bucket create omar-portfolio-tfstate
```

Then create a bucket-scoped R2 API token (dashboard → R2 → Manage R2 API
tokens → Object Read & Write, scoped to this bucket only) — separate
from `CLOUDFLARE_API_TOKEN`.

Replace `<ACCOUNT_ID>` in the `backend "s3"` block in `versions.tf` with
your Cloudflare account ID (not a secret — visible in the dashboard sidebar).

R2 credentials are passed at init time via partial backend config, never
hardcoded:

```bash
terraform init \
  -backend-config="access_key=$R2_ACCESS_KEY_ID" \
  -backend-config="secret_key=$R2_SECRET_ACCESS_KEY"
```

In CI these come from `R2_ACCESS_KEY_ID` / `R2_SECRET_ACCESS_KEY`
secrets — see `.github/workflows/deploy-infra.yml`.

State locking uses `use_lockfile = true` (Terraform ≥1.11, conditional
write, no DynamoDB needed).

## Local usage

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars   # fill in real values
export CLOUDFLARE_API_TOKEN="your-token"
export R2_ACCESS_KEY_ID="your-r2-access-key-id"
export R2_SECRET_ACCESS_KEY="your-r2-secret-access-key"

terraform init \
  -backend-config="access_key=$R2_ACCESS_KEY_ID" \
  -backend-config="secret_key=$R2_SECRET_ACCESS_KEY"

terraform plan
terraform apply
```

## CI

`deploy-infra.yml` only runs `plan`/`apply` when `terraform/**` changed
in the push, gated behind the `infra` environment (manual approval).
