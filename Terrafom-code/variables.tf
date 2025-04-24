# This file is part of the Terraform with Azure DevOps project.
# This file defines the input variables for the Terraform configuration.

# This variable is for specifying the instance type to be used for the EC2 instance.
variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

# This Variable is for sprecifying the AMI ID to be used for the EC2 instance.
variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-084568db4383264d4"
}

# This variable is for specifying the tags to be used for the EC2 instance.
variable "tags_name" {
  description = "The name of the instance"
  type        = string
  default     = "DevOps-Instance"
}

# This variable is for specifying the Security Group name to be used for the EC2 instance.
variable "SG_name" {
  description = "The name of the security group"
  type        = string
  default     = "SG-for-devops"

}

