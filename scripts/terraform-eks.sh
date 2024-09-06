#!/bin/bash

#still prompts for password for git
branch_name=jenkins-terraform
giturl=https://github.com/yap-john/playground.git

git clone  $giturl

cd playground/eks-terraform/
terraform init
terraform plan
terraform apply --auto-approve
terraform output > terraform_outputs

sh ./setup-workers.sh
echo "Setting up worker nodes connection"

# Variables
eksClusterName=demo-eks
instanceRole=$(grep -rnw terraform_outputs -e NodeInstanceRole | cut -d '"' -f2)
configMapFile=aws-auth-cm.yaml
albsvcFile=alb-svc.yaml

# Config for kubectl access
aws eks update-kubeconfig --region us-east-1 --name $eksClusterName

# Configmap for eks
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/$configMapFile
sed -i "s|rolearn: .*|rolearn: $instanceRole|" $configMapFile
kubectl apply -f $configMapFile

# Setup load balancer for web-app 
kubectl apply -f $albsvcFile

echo "Script execution completed"
