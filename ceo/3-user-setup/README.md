# Steps

1. Ideally, you would be running an Organisation, and have your employees log in to their accounts. In order to simulate this, create/use 5 more Google accounts.

2. Run the following commands to set the GMAIL IDs of the users and make them available as variables to Terraform  
**These should be different from your primary GMAIL ID**  
Ref: https://developer.hashicorp.com/terraform/cli/config/environment-variables#tf_var_name
```
export TF_VAR_DS1_gmail="enter 1st gmail account here@gmail.com"
export TF_VAR_DS2_gmail="enter 2nd gmail account here@gmail.com"
export TF_VAR_DS3_gmail="enter 3rd gmail account here@gmail.com"
export TF_VAR_MLOps_gmail="enter 4th gmail account here@gmail.com"
export TF_VAR_Infra_gmail="enter 5th gmail account here@gmail.com"
```


3. Create a directory for storing SSH keys for these users
Use the existing folder '.ssh' in the home directory. This folder usually contains ssh keys
```
mkdir ~/.ssh/
```


4. Run the Terraform commands to create the users & assign them to their teams/projects (see file for more comments):
```
cd ceo/3-user-setup
terraform init
terraform plan
terraform apply -auto-approve
```


5. To verify these changes:
- log into Google Cloud Console using your **primary** (CEO) email ID
- navigate through the projects looking at the IAM section as well as Enabled APIs. 
- view available [Google Cloud Source Repositories](https://source.cloud.google.com/)
- log out & repeat the above steps for all other email IDs, one at a time
