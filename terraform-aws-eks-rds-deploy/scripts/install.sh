#! /bin/bash

cd scripts/binaries

#Install required binaries
sudo yum install epel-release -y 
sudo yum update -y
sudo yum install -y jq
sudo yum install -y wget
sudo yum install -y unzip

# Install Terraform
sudo wget https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip -o terraform_linux_amd64.zip
sudo unzip terraform_linux_amd64.zip
sudo mv terraform /usr/local/bin/

#######################################

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#######################################

# Install aws-iam-authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
sudo mv aws-iam-authenticator /usr/local/bin/
sudo chmod +x /usr/local/bin/aws-iam-authenticator

#######################################

# Install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh

################################################

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
