// VPC VARIABLES

variable "region" {
    description = "region where it will be deployed"
    default = "us-east-1"
    type = string
}

variable "project_name" {
    description = "name of the project"
    default = "capstone"
    type = string
}

variable "infra_version" {
    description = "version of the infra"
    default = "01"
    type = string
}

variable "vpc_cidr" {
    description = "cidr block vpc will use"
    type = string
}

variable "vpc_azs" {
    description = "azs"
    type = list(string)  
}

variable "vpc_private_subnet" {
    description = "private subnets"
    type = list(string) 
}

variable "vpc_public_subnet" {
    description = "private subnets"
    type = list(string) 
}


// EC2 VARIABLES

variable "ec2_ami" {
    description = "ami for ec2 instance"
    default = "ami-0e86e20dae9224db8"
    type = string
}

variable "ec2_instance_type" {
    description = "instance type for ec2 instance"
    default = "t3.medium"
    type = string
}

variable "ec2_key_pair" {
    description = "key pair for ec2 instance"
    default = "ec2_key"
    type = string
}