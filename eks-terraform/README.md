### VPC connection via tags

#### NOTE: make sure vpc tag exists..

#### To tailor this cluster to a specific VPC, adjust the configurations below:
### data.tf:

#### data "aws_vpc" "<insert vpc reference variable>" {
####  filter {
####    name   = "tag:Name"
####    values = ["<insert vpc's Name tag'>"]
####  }
#### }

#### data "aws_subnets" "public" {
####  filter {
####    name   = "vpc-id"
####    values = [data.aws_vpc.<insert vpc's reference variable>.id]
####  }
####  ...
#### }

### nodes.tf:
#### data "aws_subnets" "public" {
####  filter {
####    name   = "vpc-id"
####    values = [data.aws_vpc.<insert vpc's reference variable>.id]
####  }

#### terraform init
#### terraform plan
#### terraform apply
