#!/bin/bash

set -e

terraform init > terraform_init.log 2>&1
terraform plan > terraform_init.log 2>&1
terraform apply --auto-approve > terraform_init.log 2>&1
terraform output > terraform_outputs
