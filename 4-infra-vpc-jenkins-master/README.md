# About
The Infrastructure Engineer uses Terraform to provision:
- Jenkins master & 1 agent
- GitLab
in a VPC dedicated to the project 'my-org-infra'  
  
  
This file will provision a VM to act as the Jenkins Master


# Steps
1. Login to GCP using the email in env variable TF_VAR_Infra_gmail
```
gcloud auth application-default login
```

2. Set up a GCP bucket as the Terraform backend for all Terraform operations by this user
```
cd 4-infra-vpc-jenkins-master/setup_backend
terraform init
terraform plan
terraform apply -auto-approve
```


3. Log into Cloud Console with the email in env variable TF_VAR_Infra_gmail & enable the following APIs:
- Compute Engine API


4. Create a temporary directory for SSH keys for the Infrastructure engineer (and other users too)  
Use the existing folder '.ssh' in the home directory. This folder usually contains ssh keys
```
mkdir ~/.ssh/tmp/
mkdir ~/.ssh/tmp/infra_engr
```


5. Create an SSH key for use by the Infrastructure engineer with:
- file name: 'id_rsa'
- username: infra_engineer
```
ssh-keygen -f ~/.ssh/tmp/infra_engr/id_rsa  -C "infra_engineer"
```
This will generate 2 files in the local folder "~/.ssh/tmp/infra_engr":
- id_rsa, which is the private key
- id_rsa.pub, which is the public key and has to be uploaded to the VM  
Refer: https://cloud.google.com/compute/docs/instances/access-overview


6. Set up the VPC & infrastructure using Terraform ( see file 'infra-jenkins-vpc-master.tf' for more comments):
```
cd 4-infra-vpc-jenkins-master
terraform init
terraform plan
terraform apply -auto-approve
```
The IP address of the VM created for the Jenkins master will be printed out by Terraform


7. Note the IP address & URL of the Jenkins Master from the step above


8. Verify that SSHing into the Jenkins VM with the username 'infra_engineer' is possible, by using the SSH key generated:
```
ssh  -i ~/.ssh/tmp/infra_engr/id_rsa   infra_engineer@ENTER_IP_ADDRESS_HERE
```


9. In order to verify that Jenkins was installed and get the Jenkins admin password:
    1. Wait about 10 minutes for installation of Jenkins
    2. SSH into the VM & check the output of following commands
```
sudo systemctl status jenkins

netstat -tunlp | grep 8080

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

