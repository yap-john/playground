#!/bin/bash

eksClusterName=demo-eks

# Config for kubectl access
aws eks update-kubeconfig --region us-east-1 --name $eksClusterName

ansible-playbook -i inventory capstone-deploy.yaml

#add required files in this directory
