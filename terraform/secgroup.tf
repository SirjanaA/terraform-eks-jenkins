# Security Group for HTTP Access
resource "aws_security_group" "allow-http" {
  name        = "allow-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.jenkins-vpc.id # Essential: Link to your VPC

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_cidr] # Use a variable for flexibility and security
    description = "HTTP Access"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] # Allow all outbound (review and restrict as needed)
    ipv6_cidr_blocks = ["::/0"] # Allow all outbound IPv6 (review and restrict as needed)

  }
}
# Security Group for SSH Access
resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.jenkins-vpc.id # Essential: Link to your VPC


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr] # Use a variable to restrict SSH access
    description = "SSH Access"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] # Allow all outbound (review and restrict as needed)
    ipv6_cidr_blocks = ["::/0"] # Allow all outbound IPv6 (review and restrict as needed)
  }
}

