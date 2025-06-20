# Provider 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"

}

# IP addresses 

locals {
  region          = "us-east-1"
  name            = "jen-eks-cluster"
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  eks_node_group_subnets = ["10.0.7.0/24", "10.0.8.0/24"] # Added for EKS node groups
  tags = {
    Example = local.name
  }
}