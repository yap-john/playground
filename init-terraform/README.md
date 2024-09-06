# capstone-iaac

### After Starting your aws playground, pls create new access keys and export it on your local

#### sample: 
#### export AWS_ACCESS_KEY_ID="AKIA2UC3ERDNML3TJUUF"
##### export AWS_SECRET_ACCESS_KEY="OLa8+qeB2mgLbAzXRcpgm+/RcIFi1/DnYf9Y46XA"

## Jenkinsfile prerequisites
### Setup global credentials for:
####  AWS_ACCESS_KEY_ID 
####  AWS_SECRET_ACCESS_KEY
####  GIT_CREDS

# Terraform VPC and EC2 for jenkins
## commands to create the basic infra
### terraform init
### terraform plan -var-file=vpc-jenkins-01.tfvars
### terraform apply -var-file=vpc-jenkins-01.tfvars




