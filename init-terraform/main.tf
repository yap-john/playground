#credentials
#create user first then generate access keys

# Specify the provider and region
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-vpc-${var.infra_version}"
  cidr = var.vpc_cidr
  
  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnet
  public_subnets  = var.vpc_public_subnet

  enable_nat_gateway = true
  #enable_vpn_gateway = true
  manage_default_security_group = false
  manage_default_route_table = false
  manage_default_network_acl = false

  tags = {
    Terraform = "true"
    Name      = "${var.project_name}-vpc-${var.infra_version}"
  }
}

# SECURITY GROUP
module "vpc_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.project_name}-vpc-${var.infra_version}-sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id   #will get the vpc_id from the created vpc

  ingress_cidr_blocks      = [var.vpc_cidr]
  ingress_rules            = ["all-all"]
  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.project_name}-jenkins-${var.infra_version}-sg"
  description = "SG for jenkins"
  vpc_id      = module.vpc.vpc_id   #will get the vpc_id from the created vpc

  ingress_cidr_blocks      = [var.vpc_cidr]
  ingress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}


# EC2 KEY PAIR
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = var.ec2_key_pair
  create_private_key = true
}

# Define an AWS EC2 instance in the public subnet
# resource "aws_instance" "chan-ec2" {
#   ami           = "ami-066784287e358dad1" # Example AMI ID for Amazon Linux 2 in us-east-1
#   instance_type = "t2.micro"
#   subnet_id     = module.vpc.public_subnets[0]
#   security_groups = [aws_security_group.pathway-sg.id]
  

#   # User data script for installing Java 17 and Docker
#   user_data = <<-EOF
#               #!/bin/bash
#               # Update the system
#               yum update -y

#               # Install Java 17
#               amazon-linux-extras install java-openjdk17 -y

#               # Install Docker
#               amazon-linux-extras install docker -y

#               # Start Docker service
#               service docker start

#               # Add the ec2-user to the docker group
#               usermod -a -G docker ec2-user
              
#               # Print Docker and Java versions
#               docker --version
#               java -version

#               # Pull and run Jenkins Docker container
#               docker pull chanchanoo/pathways-jenkins-image:latest
#               docker run -d -p 8080:8080 -p 50000:50000 --name jenkins --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock chanchanoo/pathways-jenkins-image:latest

#               # Print Docker container status
#               docker ps
#             EOF

#   tags = {
#     Name = "chan-ec2"
#   }
# }

module "jenkins_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-jenkins-${var.infra_version}"
  ami                   = var.ec2_ami
  instance_type          = var.ec2_instance_type
  key_name               = null
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_sg.security_group_id]
  availability_zone     = module.vpc.azs[0]
  subnet_id             = module.vpc.public_subnets[0]
  create_eip             = true
  disable_api_stop       = false
  #placement_group        = aws_placement_group.web.id
  enable_volume_tags = false
  root_block_device = [
    {
      volume_size           = 30
      volume_type           = "gp3"  
      delete_on_termination  = true 
    }
  ]

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  

    # User data script for installing Java 17 and Docker
  user_data = templatefile("ec2-user-data-script.tpl", {})

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      throughput  = 200
      encrypted   = true
      #kms_key_id  = aws_kms_key.this.arn
      tags = {
        MountPoint = "/mnt/data"
      }
    }
  ]

  tags = {
  #  Terraform   = "true"
  #  Environment = "dev"
  }
}
# module "key_pair" {
#   source = "terraform-aws-modules/key-pair/aws"

#   key_name           = "${var.project_name}-jenkins-${var.infra_version}-keypair"
#   create_private_key = true
# }
