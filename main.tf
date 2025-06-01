# VPC

resource "aws_vpc" "jenkins-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

}

# subnets

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.jenkins-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.jenkins-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.jenkins-vpc.id
  
}


# Route table & internet gateway

resource "aws_route_table" "jenkins_rt" {
    vpc_id = aws_vpc.jenkins-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route = {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

}

# EKS cluster

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "devops-capstone-project"
  cluster_version = "1.31"


  cluster_endpoint_public_access = true


  vpc_id                   = aws_vpc.jenkins-vpc.id
  subnet_ids               = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  control_plane_subnet_ids = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  # EKS Managed Node Groups

  eks_managed_node_groups = {
      instance_types = ["t2.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
