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



variable "DS1_gmail" {
  type = string
  description = "Gmail ID of Data Scientist 1"
}


variable "DS2_gmail" {
  type = string
  description = "Gmail ID of Data Scientist 2"
}


variable "DS3_gmail" {
  type = string
  description = "Gmail ID of Data Scientist 3"
}


variable "MLOps_gmail" {
  type = string
  description = "Gmail ID of MLOps Engineer"
}


variable "Infra_gmail" {
  type = string
  description = "Gmail ID of Infra Engineer"
}



# references:
#  Terraform: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
#  Google ref for ALL roles: https://cloud.google.com/iam/docs/understanding-roles#predefined


# 1 Data scientist in project 'ds-ml-app1'
resource "google_project_iam_binding" "ds1-binding-1" {
  project = "ds-ml-app1"
  role    = "roles/source.writer"

  members = [
    "user:${var.DS1_gmail}"
  ]
}


# # grant DS1 view access to the project, in Google Cloud console
# resource "google_project_iam_binding" "ds1-binding-2" {
#   project = "ds-ml-app1"
#   role    = "roles/resourcemanager.folderViewer"

#   members = [
#     "user:${var.DS1_gmail}"
#   ]
# }


# 2 Data scientists in project 'ds-ml-app2'
resource "google_project_iam_binding" "ds2-binding-1" {
  project = "ds-ml-app2"
  role    = "roles/source.writer"

  members = [
    "user:${var.DS2_gmail}",
    "user:${var.DS3_gmail}"
  ]
}

# # grant DS2 & DS3 view access to the project, in Google Cloud console
# resource "google_project_iam_binding" "ds2-binding-2" {
#   project = "ds-ml-app2"
#   role    = "roles/resourcemanager.folderViewer"

#   members = [
#     "user:${var.DS2_gmail}",
#     "user:${var.DS3_gmail}"
#   ]
# }


# ================= MLOPs engineer =================
# admin of the project 'my-org-mlops'
resource "google_project_iam_binding" "mlops-binding-1" {
  project = "my-org-mlops"
  role    = "roles/resourcemanager.organizationAdmin"
  members = ["user:${var.MLOps_gmail}"]
}


# ================= Infra engineer =================
# resource manager of the project 'my-org-infra'
resource "google_project_iam_binding" "infra-binding-1" {
  project = "my-org-infra"
  role    = "roles/resourcemanager.organizationAdmin"
  members = ["user:${var.Infra_gmail}"]
}


# storage manager of the project 'my-org-infra'
resource "google_project_iam_binding" "infra-binding-2" {
  project = "my-org-infra"
  role    = "roles/storage.admin"
  members = ["user:${var.Infra_gmail}"]
}


# ability to administrate Compute Engine resources in the project 'my-org-infra'
resource "google_project_iam_binding" "infra-binding-3" {
  project = "my-org-infra"
  role    = "roles/compute.admin"
  members = ["user:${var.Infra_gmail}"]
}


# ability to administrate Network resources in the project 'my-org-infra'
resource "google_project_iam_binding" "infra-binding-4" {
  project = "my-org-infra"
  role    = "roles/networkmanagement.admin"
  members = ["user:${var.Infra_gmail}"]
}

resource "google_project_iam_binding" "infra-binding-5" {
  project = "my-org-infra"
  role    = "roles/compute.networkAdmin"
  members = ["user:${var.Infra_gmail}"]
}

# ability to use service accounts
# ref: https://cloud.google.com/iam/docs/understanding-roles#iam.serviceAccountUser
resource "google_project_iam_binding" "infra-binding-6" {
  project = "my-org-infra"
  role    = "roles/iam.serviceAccountUser"
  members = ["user:${var.Infra_gmail}"]
}

# ref: https://cloud.google.com/iam/docs/understanding-roles#serviceusage.serviceUsageAdmin
resource "google_project_iam_binding" "infra-binding-7" {
  project = "my-org-infra"
  role    = "roles/serviceusage.serviceUsageAdmin"
  members = ["user:${var.Infra_gmail}"]
}

# ================= common to MLOps & Infra engineer =================
# MLOPs engineer & Infra engineer are also admins of source code repositories of both teams of Data Scientists
resource "google_project_iam_binding" "source-repo-admin-binding-1" {
  project = "ds-ml-app1"
  role    = "roles/source.admin"

  members = [
    "user:${var.MLOps_gmail}",
    "user:${var.Infra_gmail}"
  ]
}

resource "google_project_iam_binding" "source-repo-admin-binding-2" {
  project = "ds-ml-app2"
  role    = "roles/source.admin"

  members = [
    "user:${var.MLOps_gmail}",
    "user:${var.Infra_gmail}"
  ]
}
