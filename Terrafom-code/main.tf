# This file is part of the Terraform with Azure DevOps project.
# This project demonstrates how to use Terraform to provision AWS resources and deploy the azure hosted client on an EC2 instance.
# The project is designed to be used with Azure DevOps for CI/CD pipelines. 
# The project includes a main.tf file that defines the AWS resources to be provisioned, including a VPC, security group, and EC2 instance.
# The project also includes a variables.tf file that defines the input variables for the Terraform configuration.
# The project is intended to be used as a starting point for building and deploying applications on AWS using Terraform and Azure DevOps.


# This Block is for the Terraform provider and version
# It specifies the AWS provider and the version to be used in the Terraform configuration.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# This block is for the SG (Security Group) resource.
# It creates a security group in the specified VPC with the given ingress and egress rules.
resource "aws_security_group" "SG-for-devops" {
  name        = var.SG_name
  description = "Security group for DevOps project"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "aws_security_group"
    project = "Terraform-with-AzureDevOps"
  }
}

# This block is for the VPC (Virtual Private Cloud) resource.
# It creates a VPC with the specified CIDR block and tags.
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "VPC"
    project = "Terraform-with-AzureDevOps"
  }
}

# This block is for the subnet resource.
# It creates a public subnet in the specified VPC with the given CIDR block and availability zone.
resource "aws_subnet" "new-pub-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "new-pub-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

# This block is for the internet gateway resource.
# It creates an internet gateway and attaches it to the specified VPC.
resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "Internet Gateway"
    project = "Terraform-with-AzureDevOps"
  }
}

# This block is for the route table resource.
# It creates a route table in the specified VPC and adds a route to the internet gateway.
resource "aws_route_table" "new-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new-igw.id
  }
  tags = {
    Name    = "Route Table"
    project = "Terraform-with-AzureDevOps"
  }
}

# This block is for the route table association resource.
# It associates the route table with the specified subnet.
resource "aws_route_table_association" "new-route-table-assoc" {
  subnet_id      = aws_subnet.new-pub-subnet.id
  route_table_id = aws_route_table.new-route-table.id
}
resource "aws_route_table_association" "new-route-table-assoc-2" {
  subnet_id      = aws_subnet.new-pub-subnet-2.id
  route_table_id = aws_route_table.new-route-table.id
}

# This block is for the EC2 instance resource.
# It creates an EC2 instance in the specified subnet with the given AMI ID, instance type, and security group.
resource "aws_instance" "NewInstance-SSH" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.new-pub-subnet.id
  associate_public_ip_address = true

  tags = {
    Name    = var.tags_name
    project = "Terraform-with-AzureDevOps"
  }
  vpc_security_group_ids = [aws_security_group.SG-for-devops.id]
  key_name               = "Pro-Key-pair"
}

# This block is for the output variables.
# It outputs the public IP address of the created EC2 instance.
output "instance_public_ip" {
  value = aws_instance.NewInstance-SSH.public_ip
}

