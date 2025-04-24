#!/bin/bash
set -e

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y curl unzip tar git ca-certificates apt-transport-https gnupg lsb-release software-properties-common

###############################
# 1. Install Python 3.9
###############################
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update -y
sudo apt-get install -y python3.9 python3.9-venv python3.9-dev

###############################
# 2. Install Docker CE
###############################
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

###############################
# 3. Install AWS CLI v2
###############################
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip -q /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install
rm -rf /tmp/awscliv2.zip /tmp/aws


###############################
# 4. Install eksctl
###############################
curl -LO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz"
tar -xzf eksctl_Linux_amd64.tar.gz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
rm eksctl_Linux_amd64.tar.gz

###############################
# 5. Install kubectl
###############################
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

###############################
# 6. Install Azure DevOps Agent
###############################
sudo mkdir -p /opt/azure-agent
cd /opt/azure-agent
# Download the Azure DevOps agent binaries (adjust version if needed)
sudo curl -L -o agent.tar.gz https://vstsagentpackage.azureedge.net/agent/3.225.0/vsts-agent-linux-x64-3.225.0.tar.gz
sudo tar -xzf agent.tar.gz
sudo chown -R ubuntu:ubuntu /opt/azure-agent
rm agent.tar.gz

###############################
# 7. Reboot the instance
###############################
sudo reboot