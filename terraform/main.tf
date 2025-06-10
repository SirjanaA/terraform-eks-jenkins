# VPC configuration
resource "aws_vpc" "jenkins-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "jenkins-vpc"
    }
}
