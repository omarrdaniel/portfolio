# omar-portfolio

Personal site and case study archive — Cloud & Application Security.
Built and shipped the same way I'd approach a client engagement:
infrastructure as code, a gated CI/CD pipeline, and edge security
controls that are actually verified post-deploy, not just configured
once and assumed to work.

**Live:** https://omardaniel.dev

## Stack

| Layer | Choice |
|---|---|
| Frontend | [Astro](https://astro.build) + Tailwind — static output, no client-side JS by default |
| Hosting | Cloudflare Pages |
| DNS / WAF / Rate limiting | Cloudflare, managed as code via Terraform |
| State backend | Cloudflare R2 (S3-compatible), native lockfile locking |
| CI/CD | GitHub Actions |

## Security engineering in this repo

- **`security.txt`** (RFC 9116) at `/.well-known/security.txt` for coordinated
  vulnerability disclosure
- **WAF & rate limiting as code** (`terraform/waf.tf`, `terraform/rate_limit.tf`) — custom ruleset
  blocking on Cloudflare threat score, challenge rules on abnormal
  request rates, TLS 1.2 minimum, strict SSL mode
- **CSP, HSTS, X-Frame-Options, Permissions-Policy** set via `public/_headers`
  and verified against the live site after every deploy, not just declared
- **SAST** (CodeQL), **secret scanning** (gitleaks), **dependency scanning**
  (npm audit), and **IaC scanning** (tfsec) gate every pull request
- **DAST**: OWASP ZAP baseline scan runs against production after each deploy
- **Least-privilege credentials**: separate tokens for DNS/Pages/WAF vs.
  Terraform state storage; infra changes require manual approval, app
  deploys don't
- **Remote state on R2** with conditional-write locking, no long-lived
  static credentials committed anywhere in git history

## Repository structure

```
src/
  content/projects/    case studies as Markdown — drop a file, get a page
  components/          Astro components
  pages/                routes (home + dynamic /projects/[slug])
terraform/              Cloudflare infra: DNS, Pages project, WAF, rate limiting, www redirect
.github/workflows/
  ci.yml                build, SAST, secret scan, dependency scan, IaC scan
  deploy-infra.yml       terraform apply — only when terraform/** changes
  deploy-site.yml        build + deploy to Cloudflare Pages, every push
```

## Adding a case study

New Markdown file in `src/content/projects/`, frontmatter per the schema
in `src/content.config.ts`. Picked up automatically by the listing and
the dynamic route — no component changes needed.

Client names are withheld under confidentiality agreements; sector,
scale, and specific identifying detail are generalized so no single
case study is attributable to a real client.

## Local development

```bash
npm install
npm run dev       # localhost:4321
npm run build
```

## CI/CD

Three workflows, each scoped to what actually needs to run:

- **`ci.yml`** — every PR and push to main: type-check, build, CodeQL,
  gitleaks, npm audit, tfsec. Any failure blocks merge.
- **`deploy-infra.yml`** — runs after CI passes, but only applies
  Terraform if `terraform/**` changed. Gated behind the `infra`
  environment (required reviewer).
- **`deploy-site.yml`** — runs after CI passes, deploys the built site
  to Cloudflare Pages on every push, then runs a ZAP baseline scan and
  checks the expected security headers are present on the live response.

See `terraform/README.md` for infra setup details.

## Required GitHub configuration

- **Secrets:** `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`
- **Variables:** `SITE_DOMAIN`, `PAGES_DEV_SUBDOMAIN` (the real `<x>.pages.dev` value from the dashboard — see `terraform/README.md`)
- **Environments:** `infra` (required reviewer), `production` (lighter gate)

## Contact

[LinkedIn](https://www.linkedin.com/in/omarrdaniel/) · [GitHub](https://github.com/omarrdaniel)
