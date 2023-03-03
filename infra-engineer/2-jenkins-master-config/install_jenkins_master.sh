#! /bin/bash

# ref: 
# 1. https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#downloading-and-installing-jenkins
# 2. https://pkg.jenkins.io/debian/
# 3. https://www.rosehosting.com/blog/how-to-install-jenkins-on-debian-11/

# commands for installation of Jenkins

sudo apt update -y && sudo apt upgrade -y

#sudo apt install openjdk-11-jdk default-jre gnupg2 apt-transport-https wget -y
sudo apt install gnupg2 apt-transport-https -y

#wget https://pkg.jenkins.io/debian/jenkins.io.key
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

#sudo apt-key add jenkins.io.key

#echo "deb https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y

sudo apt-get install fontconfig openjdk-11-jre -y

sudo apt-get install jenkins -y

sudo systemctl start jenkins && sudo systemctl enable jenkins
