# omar-portfolio

Personal portfolio site — built with the same discipline I'd bring to a
client engagement: infrastructure as code, a DevSecOps pipeline, and
security headers that actually get checked, not just configured once and
forgotten.

**Live at:** https://omardaniel.dev *(update once domain is live)*

## Stack

| Layer | Choice | Why |
|---|---|---|
| Site | [Astro](https://astro.build) + Tailwind | Static output, ships near-zero JS, fast on any tier of hosting |
| Hosting | Cloudflare Pages | Free tier, global edge, integrates with the rest of the Cloudflare config below |
| DNS / WAF / Rate limiting | Cloudflare, managed via Terraform | Same platform I work with daily — config here mirrors real client work |
| CI/CD | GitHub Actions | Free for public repos, wide ecosystem of security-scanning actions |

## Repository structure

```
src/
  content/projects/    ← case studies as Markdown (add a file, get a page)
  components/          ← Astro components
  pages/                ← routes (index + dynamic project pages)
terraform/              ← Cloudflare infra as code (DNS, Pages project, WAF, rate limiting)
.github/workflows/
  ci.yml                ← lint, build, SAST, secret scan, dependency scan, IaC scan (always runs)
  deploy-infra.yml       ← terraform apply — only when terraform/** changed
  deploy-site.yml        ← build + deploy to Cloudflare Pages — every push to main
```

## Adding a new case study

Add a Markdown file to `src/content/projects/`, following the frontmatter
schema in `src/content/config.ts`. No component code needed — it's picked
up automatically by both the listing section and the dynamic `/projects/[slug]`
route.

**A rule I follow for every case study:** no real client names, and no
detail specific enough that a client would be identifiable to someone in
the industry (exact sector + size + timeframe + tech stack together is
usually enough to de-anonymize something). Generalize at least one axis.

## Local development

```bash
npm install
npm run dev       # http://localhost:4321
npm run build     # outputs to dist/
```

## Pipeline design

The CI/CD setup is deliberately over-built for what a static portfolio
strictly needs — that's the point. It's meant to be readable evidence of
a DevSecOps workflow, not just a deploy script.

**Three workflows, each with a different job:**

- **`ci.yml`** runs on every PR and push to main: type-check + build,
  CodeQL (SAST), gitleaks (secret scanning), `npm audit` (dependency
  scanning), and `tfsec` (IaC scanning). Any of these failing blocks the
  merge. This one always runs — checks are cheap and have no side effects.

- **`deploy-infra.yml`** runs after CI passes on main, but only actually
  applies anything if `terraform/**` changed in that push (checked via
  `dorny/paths-filter` against the exact commit CI validated). Gated
  behind the `infra` GitHub Environment with its own manual-approval
  reviewers — DNS and WAF changes get a stricter gate than a content
  update.

- **`deploy-site.yml`** runs after CI passes on main, independently of
  the infra workflow, and deploys the built site on every push. It does
  **not** wait for or depend on a Terraform apply — the Cloudflare Pages
  project itself is created once; every push after that is just "ship
  new static files" against infrastructure that already exists. It then
  runs an OWASP ZAP baseline scan and checks that the expected security
  headers are actually present on the live site.

**Why not one combined pipeline:** a content-only commit (fixing a typo
in a case study) has no reason to run `terraform plan/apply` at all, and
shouldn't need the same approval gate as a DNS or firewall change. Coupling
the two means every deploy pays the cost and risk profile of the riskier
one. Splitting them by path and by environment is the same pattern a real
infra + app repo would use — it's a deliberate design choice here, not
just an artifact of the tooling.

**One edge case to know:** if you ever change something in Terraform that
the site deploy also depends on (e.g. renaming the Pages project itself),
the two workflows run in parallel and won't sequence automatically —
merge the infra change first, confirm it applied, then push the app
change.

See `terraform/README.md` for infra-specific setup (API token scopes,
remote state, etc.) and the comments in each workflow file for the
reasoning behind individual steps.

## Required GitHub configuration

- **Secrets:** `CLOUDFLARE_API_TOKEN` (DNS/Pages/WAF), `CLOUDFLARE_ACCOUNT_ID`, `R2_ACCESS_KEY_ID` + `R2_SECRET_ACCESS_KEY` (Terraform state backend — a separate, narrowly-scoped R2 token, see `terraform/README.md`)
- **Variables:** `SITE_DOMAIN` (e.g. `omardaniel.dev`)
- **Environments:**
  - `infra` — used by `deploy-infra.yml`; set required reviewers here (stricter gate, since it touches DNS/WAF)
  - `production` — used by `deploy-site.yml`; can have a lighter gate, since Pages deploys are atomic and instantly revertible

## License

Content and case studies © Omar Daniel. Code structure free to reference/reuse.
