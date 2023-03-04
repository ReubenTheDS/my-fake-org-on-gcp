#! /bin/bash

# commands for installation of Java
sudo apt update -y && sudo apt upgrade -y

sudo apt-get install fontconfig openjdk-11-jre -y


# The Jenkins master will control this node by issuing commands over SSH 
# All Jenkins operations on the Jenkins agent be carried out by a Linux account named 'jenkins'

# create a user 'jenkins' with home directory
sudo useradd -m jenkins

# acting as the user 'jenkins', create a folder '.ssh' where SSH keys are stored
sudo -u jenkins mkdir /home/jenkins/.ssh

# acting as the user 'jenkins', create the file where authorized SSH keys are listed
sudo -u jenkins touch /home/jenkins/.ssh/authorized_keys
