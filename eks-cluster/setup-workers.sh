#!/bin/bash

echo "Setting up worker nodes connection"

# Variables
#eksClusterName=$(terraform output -raw eks_cluster_name) <- if added in terraform output
eksClusterName=demo-eks
#instanceRole=$(grep -rnw terraform_outputs -e NodeInstanceRole | cut -d '"' -f2)
instanceRole=$(terraform output -raw NodeInstanceRole)
configMapFile=aws-auth-cm.yaml
region='us-east-1'
#albsvcFile=alb-svc.yaml

# Config for kubectl access
 aws eks update-kubeconfig --region $region --name $eksClusterName

# Configmap for eks
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/$configMapFile
sed -i "s|rolearn: .*|rolearn: $instanceRole|" $configMapFile
kubectl apply -f $configMapFile

# Setup load balancer for web-app 
#kubectl apply -f $albsvcFile
