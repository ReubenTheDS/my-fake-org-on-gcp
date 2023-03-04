# About
The Infrastructure Engineer uses this folder to provision a VM to act as the Jenkins Master


# Steps
1. Set up the VPC & Jenkins master using Terraform ( see file 'infra-jenkins-vpc-master.tf' for more comments):
```
cd infra-engineer/1-jenkins-vpc-n-master
terraform init
terraform plan
terraform apply -auto-approve
```


2. The (external) IP address & URL of the Jenkins master was printed by Terraform in the step above.  
To extract it programatically, use gcloud & jq, then create a bash variable with the IP address:
```
export GCP_JENKINS_MASTER_IP=$(gcloud compute instances list    \
    --filter="tags.items=jenkins-master" \
    --format=json | \
        jq  --raw-output  .[0].networkInterfaces[0].accessConfigs[0].natIP)

echo ${GCP_JENKINS_MASTER_IP}
```


3. Verify that SSHing into the Jenkins VM with the username 'infra_engineer' is possible, by using the SSH key generated:
```
ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_MASTER_IP}"
```


4. In order to verify that Jenkins was installed and get the Jenkins admin password:
    1. Wait about 10 minutes for installation of Jenkins
    2. Visit the URL printed out by the Terraform script
    3. SSH into the VM using the command above & check the output of following commands
```
sudo systemctl status jenkins

netstat -tunlp | grep 8080

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

5. To close the SSH session with the Jenkins master:
```
exit
```


**NOTE**
If instances are deleted manually/by Terraform, but happen to use the same IP every time, this error might occur when starting an SSH session:  
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```
To fix this, open the file 'known_hosts' on the local system & delete the entry for that reused IP address
