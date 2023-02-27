# use GCS as a remote backend
# ref: https://developer.hashicorp.com/terraform/language/settings/backends/gcs#configuration-variables
# terraform {
#   backend "gcs" {
#     bucket  = "my-fake-infra-on-gcp-bucket"
#     prefix  = "terraform/state"
#   }
# }

provider "google" {
  region      = "us-east1"
  zone        = "us-east1-b"
  project     = "my-org-infra"
}

resource "google_storage_bucket" "infra-bucket" {
  name          = "my-fake-infra-on-gcp-bucket"
  location      = "US-EAST1"
  uniform_bucket_level_access = true
  public_access_prevention = "enforced"
}

