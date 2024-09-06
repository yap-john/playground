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
