# Terraform installation

# Steps
1. Download the appropriate installer from [the official link](https://developer.hashicorp.com/terraform/downloads) & run it


2. Add an entry to the Path env variable for terraform & verify that this command passes:
```
terraform version
```


3. Create a GCS bucket to use as the backend for Terraform
```
gcloud storage buckets create gs://my-fake-org-on-gcp-bucket \
    --project="my-fake-org-on-gcp"  \
    --default-storage-class=STANDARD    \
    --location=US-EAST1 \
    --uniform-bucket-level-access   \
    --public-access-prevention
```
Ref: https://cloud.google.com/storage/docs/creating-buckets#storage-create-bucket-cli


4. List buckets
```
gcloud storage buckets list
```


5. Enter the folder `1-terraform-setup` and initialise terraform
```
cd 1-terraform-setup
terraform init
```