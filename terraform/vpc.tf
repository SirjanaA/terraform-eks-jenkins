resource "aws_vpc" "jenkins-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jenkins-vpc"
  }
}

resource "aws_subnet" "subnet-a" {
  vpc_id     = aws_vpc.jenkins-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "jenkins-vpc-subnet-a"
  }
}

resource "aws_subnet" "subnet-b" {
  vpc_id     = aws_vpc.jenkins-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "jenkins-vpc-subnet-b"
  }
}

resource "aws_internet_gateway" "jenkins-gw" {
  vpc_id = aws_vpc.jenkins-vpc.id

  tags = {
    Name = "jenkins-vpc-ig"
  }
}

resource "aws_default_route_table" "jenkins-rt" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins-gw.id
  }
  default_route_table_id = aws_vpc.jenkins-vpc.default_route_table_id
}

