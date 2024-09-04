#!/bin/bash

#setup eks cluster

terraform init > terraform_init.log 2>&1
terraform plan > terraform_init.log 2>&1
terraform apply --auto-approve > terraform_init.log 2>&1
terraform output > terraform_outputs

#setup connection between worker nodes
#prereq
#needs aws cli, export access keys, kubectl on jenkins docker container(?)

#variables
eksClusterName=demo-eks
instanceRole=$(grep -rnw terraform_outputs -e NodeInstanceRole | cut -d '"' -f2)
configMapFile=aws-auth-cm.yaml

aws eks update-kubeconfig --region us-east-1 --name $eksClusterName
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/$configMapFile
sed -i "s|rolearn: .*|rolearn: $instanceRole|" $configMapFile
kubectl apply -f $configMapFile

#show output
#kubectl get nodes -o wide
