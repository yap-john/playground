#!/bin/bash

#still prompts for password for git
#set terraform commands as a function(?)
branch_name=jenkins-terraform
giturl=https://github.com/opswerks/capstone-iaac.git

git clone --branch $branch_name $giturl

cd capstone-iaac/
terraform init
terraform plan -var-file=vpc-jenkins-01.tfvars
terraform apply -var-file=vpc-jenkins-01.tfvars --auto-approve
