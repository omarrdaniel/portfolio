resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.this.id
  name    = "@"
  type    = "CNAME"
  content = "${var.pages_dev_subdomain}.pages.dev"
  proxied = true
  ttl     = 1

  depends_on = [cloudflare_pages_domain.custom_domain]
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.this.id
  name    = "www"
  type    = "CNAME"
  content = "${var.pages_dev_subdomain}.pages.dev"
  proxied = true
  ttl     = 1
}
