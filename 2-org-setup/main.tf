# use GCS as a remote backend
# ref: https://developer.hashicorp.com/terraform/language/settings/backends/gcs#configuration-variables
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


# ref for TF billing ID: https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/billing_account
variable "ORG_BILLING_ID" {
  type = string
  description = "Billing ID to be used for all these projects"
  sensitive = true
}


# create 1 project for 1 ML team
resource "google_project" "ds-ml-app1" {
  name       = "ML App 1 Data Scientists Team"
  project_id = "ds-ml-app1"
  billing_account = var.ORG_BILLING_ID
}


# create another project for the second ML team
resource "google_project" "ds-ml-app2" {
  name       = "ML App 2 Data Scientists Team"
  project_id = "ds-ml-app2"
  billing_account = var.ORG_BILLING_ID
}


# create 1 project for the MLOps team
resource "google_project" "my-org-mlops" {
  name       = "MLOps Team"
  project_id = "my-org-mlops"
  billing_account = var.ORG_BILLING_ID
}


# create 1 project for the Infra team
resource "google_project" "my-org-infra" {
  name       = "Infra Team"
  project_id = "my-org-infra"
  billing_account = var.ORG_BILLING_ID
}
