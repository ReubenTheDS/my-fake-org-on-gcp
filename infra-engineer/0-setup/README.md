# About
Setup for Infrastructure Engineer


# Steps

1. Create a directory for SSH keys for the Infrastructure engineer
```
mkdir ~/.ssh/infra_engr
```


2. Create an SSH key for use by the Infrastructure engineer with:
- file name: 'id_rsa'
- username: infra_engineer
```
ssh-keygen -f ~/.ssh/infra_engr/id_rsa  -C "infra_engineer"
```
This will generate 2 files in the local folder "~/.ssh/infra_engr":
- id_rsa, which is the private key
- id_rsa.pub, which is the public key and has to be uploaded to the VM  

Refer: https://cloud.google.com/compute/docs/instances/access-overview


3. Login to GCP using the email in env variable TF_VAR_Infra_gmail
```
gcloud auth application-default login
```


4. Set up a GCP bucket as the Terraform backend for all Terraform operations by this user
```
cd infra-engineer/0-setup/
terraform init
terraform plan
terraform apply -auto-approve
```


5. Log into Cloud Console with the email in env variable TF_VAR_Infra_gmail & enable the following APIs:
- Compute Engine API