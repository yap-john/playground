#!/bin/bash

terraform init
terraform plan -var-file=vpc-jenkins-01.tfvars
terraform apply -var-file=vpc-jenkins-01.tfvars --auto-approve
