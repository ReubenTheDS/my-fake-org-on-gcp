# use the created infra bucket as a remote backend
# ref: https://developer.hashicorp.com/terraform/language/settings/backends/gcs#configuration-variables
terraform {
  backend "gcs" {
    bucket  = "my-fake-infra-on-gcp-bucket"
    prefix  = "terraform/state"
  }
}


provider "google" {
  region      = "us-east1"
  zone        = "us-east1-b"
}