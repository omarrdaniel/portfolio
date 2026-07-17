terraform {
  required_version = ">= 1.7.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.41"
    }
  }

  # State in R2. Bucket created manually before first init (see README).
  # Credentials passed via -backend-config at init time, not stored here.
  backend "s3" {
    bucket                      = "omar-portfolio-tfstate"
    key                         = "terraform.tfstate"
    region                      = "auto"
    endpoints                   = { s3 = "https://e06d1fc4b453f9d40d9194f9ee481843.r2.cloudflarestorage.com" }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
    use_lockfile                = true
  }
}
