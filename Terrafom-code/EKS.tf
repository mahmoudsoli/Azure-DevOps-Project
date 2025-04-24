# This file is part of the Terraform with Azure DevOps project.
# This file defines the module for creating an EKS cluster using the terraform-aws-modules/eks/aws module.
# The module is sourced from the Terraform AWS modules repository and is used to create an EKS cluster with managed node groups.
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-stagging-cluster"
  cluster_version = "1.29"
  vpc_id          = aws_vpc.vpc.id
  subnet_ids      = [aws_subnet.new-pub-subnet.id, aws_subnet.new-pub-subnet-2.id]

  eks_managed_node_groups = {
    stagging_nodes = {
      desired_size = 2
      max_size     = 3
      min_size     = 2

      instance_types = ["t2.micro"]

      ssh = {
        enable     = true
        public_key = "Pro1-Key-pair"
      }

      tags = {
        Name = "eks-node-for-stagging-cluster"
        project = "Terraform-with-AzureDevOps"
      }
    }
  }

  tags = {
    Name    = "eks-stagging-cluster"
    project = "Terraform-with-AzureDevOps"
  }
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
