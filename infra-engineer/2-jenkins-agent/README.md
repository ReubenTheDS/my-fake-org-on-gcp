# About
The Infrastructure Engineer uses this folder to provision a VM to act as the Jenkins agent


# Steps
## Jenkins agent VM setup
1. Set up the VPC & Jenkins master using Terraform ( see file 'infra-jenkins-vpc-master.tf' for more comments):
```
cd infra-engineer/1-jenkins-agent
terraform init
terraform plan
terraform apply -auto-approve
```


2. The internal & external IP addresses of the Jenkins agent was printed by Terraform in the step above.  
To extract it programatically, use gcloud & jq, then create bash variables with the IP addresses:
```
export GCP_JENKINS_AGENT_EXTERNAL_IP=$(gcloud compute instances list    \
    --filter="tags.items=jenkins-agent" \
    --format=json | \
        jq  --raw-output  .[0].networkInterfaces[0].accessConfigs[0].natIP)

export GCP_JENKINS_AGENT_INTERNAL_IP=$(gcloud compute instances list    \
    --filter="tags.items=jenkins-agent" \
    --format=json | \
        jq  --raw-output  .[0].networkInterfaces[0].networkIP)

echo ${GCP_JENKINS_AGENT_EXTERNAL_IP}
echo ${GCP_JENKINS_AGENT_INTERNAL_IP}
```


3. Verify that SSHing into the Jenkins VM with the username 'infra_engineer' is possible, by using the SSH key generated:
```
ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_AGENT_EXTERNAL_IP}"
```


4. In order to verify that Java was installed:
    1. Wait about 5 minutes for installation of Java
    2. SSH into the VM & check the output of following commands
    3. Close the SSH session
```
ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_AGENT_EXTERNAL_IP}"
java --version
exit
```


## SSH connection between VMs & Jenkins agent configuration

1. Add a hostname entry in the Jenkins master: name 'jenkins-agent' & IP address will be GCP_JENKINS_AGENT_INTERNAL_IP, since we may disable access from outside the VPC afterwards
```
ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_MASTER_IP}"   <<EOF
sudo bash -c "echo '${GCP_JENKINS_AGENT_INTERNAL_IP}  jenkins-agent' >>  /etc/hosts"

EOF
```


2. SSH into the Jenkins master and create an SSH key with:
- file name: 'id_rsa'
- username: 'jenkins' - this user was also created by Terraform during provisioning of Jenkins agent
```
ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_MASTER_IP}"
ssh-keygen -f ~/.ssh/id_rsa  -C "jenkins"
exit
```
This will generate 2 files in the folder "/home/infra_engineer/.ssh/" on the Jenkins master VM:
- id_rsa, which is the private key
- id_rsa.pub, which is the public key and has to be uploaded to the Jenkins agent VM


3. Copy the public key to a bash variable on the local machine:
```
JENKINS_MASTER_PUB_KEY=$(ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_MASTER_IP}"  'cat ~/.ssh/id_rsa.pub')
```


4. Add the public key to the file containing authorized keys in the Jenkins agent. Run the command as user 'jenkins'
```
ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_AGENT_EXTERNAL_IP}"   \
    "sudo bash -c 'echo ${JENKINS_MASTER_PUB_KEY} >> /home/jenkins/.ssh/authorized_keys'"
```
refs: 
https://superuser.com/a/1026359
https://superuser.com/a/400720


5. SSH from the local machine to the Jenkins master, and then from the Jenkins master to the Jenkins agent, then close both SSH sessions
```
ssh  -i ~/.ssh/infra_engr/id_rsa   "infra_engineer@${GCP_JENKINS_MASTER_IP}"

ssh "jenkins@jenkins-agent"

exit 

exit

```
