# Infrastructure as Code — Cloudflare

This manages the Cloudflare side of the portfolio: DNS records, the Pages
project, WAF rules, rate limiting, and baseline zone security settings.

## Prerequisites

1. Domain registered and added as a zone in Cloudflare (Cloudflare Registrar
   is the simplest option — at-cost pricing, no markup).
2. A Cloudflare API Token (not the legacy Global API Key) scoped to:
   - `Zone.DNS: Edit`
   - `Zone.Zone Settings: Edit`
   - `Account.Cloudflare Pages: Edit`
   - `Zone.Firewall Services: Edit`

## Bootstrap: create the R2 state bucket (one-time, manual)

State lives in Cloudflare R2 rather than local disk or Terraform Cloud —
free, and it keeps the whole stack on one platform. The bucket has to
exist *before* the first `terraform init`, since Terraform can't create
the bucket it's about to store its own state in.

Using `wrangler` (Cloudflare's CLI):

```bash
npx wrangler r2 bucket create omar-portfolio-tfstate
```

Or via the dashboard: R2 → Manage R2 API tokens → Create bucket.

Then create a **bucket-scoped R2 API token** (dashboard → R2 → Manage R2
API tokens → Create API token → Object Read & Write, scoped to this
bucket only). This is separate from the `CLOUDFLARE_API_TOKEN` used for
DNS/Pages/WAF. It gives you an Access Key ID and Secret Access Key.

Replace `<ACCOUNT_ID>` in the `backend "s3"` block in `main.tf` with your
Cloudflare account ID (dashboard sidebar — not a secret on its own).

**Credentials are never named "AWS" anywhere in this repo** — the backend
type is called `s3` only because that's Terraform's generic name for any
S3-compatible API, but the actual values are passed in as R2 credentials
at init time, via partial backend config:

```bash
terraform init \
  -backend-config="access_key=$R2_ACCESS_KEY_ID" \
  -backend-config="secret_key=$R2_SECRET_ACCESS_KEY"
```

In CI, these come from GitHub Actions secrets named `R2_ACCESS_KEY_ID` /
`R2_SECRET_ACCESS_KEY` — see `.github/workflows/deploy.yml`. They're
separate secrets from `CLOUDFLARE_API_TOKEN`: one job (state storage),
one token, least privilege.

**State locking:** the backend uses `use_lockfile = true` (Terraform ≥1.11),
which locks via a conditional write to a lock object in the same bucket —
no DynamoDB table needed. For a solo-maintained repo this mostly matters
if you ever run `apply` from two machines at once; it's free to leave on
regardless.

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

## CI usage

In CI, `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` are injected as
GitHub Actions secrets rather than a local `.tfvars` file — see
`.github/workflows/ci.yml`, which runs `terraform plan` (and `tfsec`) on
every pull request, and `terraform apply` only on merge to `main`.

## Why Terraform here at all

The site could run entirely from the Cloudflare Pages dashboard with zero
code. It's deliberately done as IaC instead, because the point of this
repo is to also demonstrate the workflow — reviewable infrastructure
changes, a `tfsec` scan in the pipeline, and a clear audit trail — that
matters more on a real client engagement than on a personal site.
