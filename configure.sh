#!/bin/bash
#connection between worker nodes
#prereq
#needs aws cli, export access keys, kubectl on jenkins docker container(?)

instanceRole=$(grep -rnw terraform_outputs -e NodeInstanceRole | cut -d '"' -f2)
configMapFile=aws-auth-cm.yaml

aws eks update-kubeconfig --region us-east-1 --name demo-eks
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/aws-auth-cm.yaml
sed -i "s|rolearn: .*|rolearn: $instanceRole|" $configMapFile
kubectl apply -f aws-auth-cm.yaml

#show output
#kubectl get nodes -o wide
