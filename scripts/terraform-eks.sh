#!/bin/bash

cd ../eks-terraform/

terraform init
terraform plan
terraform apply --auto-approve
terraform output > terraform_outputs

sh ./setup-workers.sh
