#! /bin/bash

# commands for installation of Java
sudo apt update -y && sudo apt upgrade -y

sudo apt-get install fontconfig openjdk-11-jre -y


# create a user 'jenkins' with home directory
sudo useradd -m jenkins

# for the user 'jenkins', create a folder '.ssh' where SSH keys will be stored
sudo -u jenkins mkdir /home/jenkins/.ssh