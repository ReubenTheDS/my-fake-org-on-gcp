# Steps
1. Note the ID of the billing account created in [0-gcp-setup](../0-gcp-setup/) and store it in an env variable:
```
export TF_VAR_ORG_BILLING_ID='enter your ID here'
```

2. Apply the file `main.tf` using Terraform (see file for more comments):
```
cd 'ceo/2-org-setup'
terraform init
terraform plan
terraform apply -auto-approve
```

3. Verify that the projects have been created
```
gcloud projects list
```

4. Using the [GCP console](https://console.cloud.google.com), enable the following APIs on the projects 'ds-ml-app1' & 'ds-ml-app2'  
- Cloud Source Repositories API  
Read: Why this should not be done through Terraform: [Ref 1](https://stackoverflow.com/a/72306829), [Ref 2](https://stackoverflow.com/a/72094901)  
