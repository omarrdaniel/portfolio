variable "domain" {
  description = "The apex domain for the portfolio (e.g. omardaniel.dev)"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID (found in the dashboard sidebar)"
  type        = string
  sensitive   = true
}
