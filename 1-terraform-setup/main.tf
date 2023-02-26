terraform {
  backend "gcs" {
    bucket  = "my-fake-org-on-gcp-bucket"
    prefix  = "terraform/state"
  }
}


provider "google" {
  region      = "us-east1"
  zone        = "us-east1-b"
}

