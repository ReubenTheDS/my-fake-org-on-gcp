# About
The Infrastructure Engineer uses Terraform to provision:
- Jenkins master & 1 agent
- GitLab
in a VPC dedicated to the project 'my-org-infra'  

# Steps
1. Login to GCP using the email in env variable TF_VAR_Infra_gmail
```
gcloud auth application-default login
```

2. Set up a GCP bucket as the Terraform backend for all Terraform operations by this user
```
cd 4-infra-vpc/setup_backend
terraform init
terraform plan
terraform apply -auto-approve
```


3. Set up the VPC & infrastructure using Terraform ( see file 'main.tf' for more comments):
```
cd 4-infra-vpc
terraform init
terraform plan
terraform apply -auto-approve
```