#!/bin/bash

# go to ubuntu
sudo su - ubuntu

# Update the system
sudo apt update -y

# Install Java 17
sudo apt install -y openjdk-17-jdk

# Install Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add the ec2-user to the docker group
# Note: On Ubuntu, the default user is typically 'ubuntu' rather than 'ec2-user'
sudo usermod -aG docker $USER
sudo usermod -aG sudo $USER

# Print Docker and Java versions
docker --version
java -version

# Pull and run Jenkins Docker container
sudo docker pull chanchanoo/capstone-jenkins:latest
sudo docker run -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home chanchanoo/capstone-jenkins:latest

# Print Docker container status
sudo docker ps

# Install Ansible & Dependencies
sudo apt install -y ansible 
sudo apt install -y unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo apt install python3-pip -y
sudo pip3 install boto3 --break-system-packages

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm




