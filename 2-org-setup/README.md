# Org Structure
The Organisation consists of:
- The CEO & GCP project owner i.e. you
- 2 Data Scientists
- 1 MLOPs engineer
- 1 Infrastructre engineer  
![Org Structure](./Org%20structure.jpg)

# Steps
1. Using the Google Cloud console, create a billing account. Note its ID and store it in an env variable:
```
export TF_VAR_ORG_BILLING_ID='enter your ID here'
```

1. Plan & then apply the file `main.tf` using Terraform (see file for more comments):
```
cd '2-org-setup'
terraform init
terraform plan
terraform apply -auto-approve
```

1. Verify that the projects have been created
```
gcloud projects list
```

1. Using the [GCP console](https://console.cloud.google.com), enable the following APIs on the projects 'ds-ml-app1' & 'ds-ml-app2'  
- Cloud Source Repositories API  
Read: Why this should not be done through Terraform: [Ref 1](https://stackoverflow.com/a/72306829), [Ref 2](https://stackoverflow.com/a/72094901)  