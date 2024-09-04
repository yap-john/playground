#!/bin/bash

# Echo start
echo "Starting EKS cluster setup"

# Setup EKS cluster
echo "Running terraform init"
terraform init > terraform_init.log 2>&1
echo "Running terraform plan"
terraform plan > terraform_plan.log 2>&1
echo "Running terraform apply"
terraform apply --auto-approve > terraform_apply.log 2>&1
echo "Terraform output"
terraform output > terraform_outputs

# Setup connection between worker nodes
echo "Setting up AWS CLI and kubectl"
eksClusterName=demo-eks
instanceRole=$(grep -rnw terraform_outputs -e NodeInstanceRole | cut -d '"' -f2)
configMapFile=aws-auth-cm.yaml

aws eks update-kubeconfig --region us-east-1 --name $eksClusterName
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/$configMapFile
sed -i "s|rolearn: .*|rolearn: $instanceRole|" $configMapFile
kubectl apply -f $configMapFile

echo "Script execution completed"
