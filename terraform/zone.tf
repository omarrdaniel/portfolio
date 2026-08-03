# domain already registered + added as a zone manually
data "cloudflare_zone" "this" {
  filter = {
    name = var.domain
  }
}
