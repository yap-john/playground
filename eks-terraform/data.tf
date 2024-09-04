###############################################################
#
# This file contains configuration for all data source queries
#
###############################################################

# Get the default VPC details
data "aws_vpc" "terra_vpc" {
  filter {
    name   = "tag:Name"
    values = ["terra-vpc"]
  }
}

# Get Public IP of where you run terraform from. This allows us to lock down SSH and node access
# into the environment from anyone other than yourself, by inserting your public
# IP to a security group ingress rule.
# Try this URL in your browser!
data "localos_public_ip" "users_ip" {
}

# Get the subnets to use for the cluster ti bind to and the autoscaling group
# to place nodes in.
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.terra_vpc.id]
  }
  filter {
    name = "availability-zone"
    values = [
      "${var.aws_region}a",
      "${var.aws_region}b",
      "${var.aws_region}c"
    ]
  }
}

# Get AMI ID for latest recommended Amazon Linux 2 image
data "aws_ssm_parameter" "node_ami" {
  name = "/aws/service/eks/optimized-ami/1.24/amazon-linux-2/recommended/image_id"
}
