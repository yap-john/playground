#!/bin/bash

terraform init
terraform plan
terraform apply --auto-approve
terraform output > terraform_outputs

