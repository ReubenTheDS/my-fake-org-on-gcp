# About
The Infrastructure Engineer uses this folder to provision a VM to act as the Jenkins Master


# Steps
1. Set up the VPC & Jenkins master using Terraform ( see file 'infra-jenkins-vpc-master.tf' for more comments):
```
cd infra-engineer/1-jenkins-setup
terraform init
terraform plan
terraform apply -auto-approve
```
The IP address of the VM created for the Jenkins master will be printed out by Terraform


2. Note the IP address & URL of the Jenkins Master from the step above


3. Verify that SSHing into the Jenkins VM with the username 'infra_engineer' is possible, by using the SSH key generated:
```
ssh  -i ~/.ssh/tmp/infra_engr/id_rsa   infra_engineer@ENTER_IP_ADDRESS_HERE
```


4. In order to verify that Jenkins was installed and get the Jenkins admin password:
    1. Wait about 10 minutes for installation of Jenkins
    2. Visit the URL printed out by the Terraform script
    3. SSH into the VM & check the output of following commands
```
sudo systemctl status jenkins

netstat -tunlp | grep 8080

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

**NOTE**
If instances are deleted manually/by Terraform, but happen to use the same IP every time, this error might occur when starting an SSH session:  
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```
To fix this, open the file 'known_hosts' & delete the entry for that reused IP address
