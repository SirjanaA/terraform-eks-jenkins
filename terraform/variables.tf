variable "project" {
  type        = string
  description = "The name of the current project."
  default     = "jenkins-project"
}

variable "region" {
  type        = string
  description = "The AWS region to deploy in." # Added description
  default     = "us-east-1"
}

variable "image_id" {
  type        = map(string)
  description = "The ID of the machine image (AMI) to use for the server, per region."
  default = {
    us-east-1 = "ami-04d32dab8ea739477" # Replace with your desired AMI
  }
}

variable "instance_type" {
  type        = string
  description = "The size of the VM instances."
  default     = "t2.micro"
}

variable "instance_count_min" {
  type        = number
  description = "Minimum number of instances to provision."
  default     = 1
  validation {
    condition     = var.instance_count_min >= 1 && var.instance_count_min <= 10 # Validate against fixed bounds
    error_message = "Instance count min must be between 1 and 10."
  }
}

variable "instance_count_max" {
  type        = number
  description = "Maximum number of instances to provision."
  default     = 3
  validation {
    condition     = var.instance_count_max >= 1 && var.instance_count_max <= 10 # Validate against fixed bounds
    error_message = "Instance count max must be between 1 and 10."
  }
}

resource "null_resource" "instance_count_validation" { # Dummy resource for validation

  provisioner "local-exec" {
    command = "echo 'Validating instance counts...'" # Optional: Print a message
  }
}


variable "add_public_ip" {
  type        = bool
  description = "Whether to assign public IPs to instances." # Added description
  default     = true
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
  default     = "10.10.0.0/16" # Consider aligning with your VPC resource
}

variable "allowed_http_cidr" {
  type        = string
  description = "CIDR block allowed to access HTTP (port 80).  **CHANGE THIS TO YOUR SPECIFIC IP OR RANGE!**"
  default     = "0.0.0.0/0" # **DANGER: Wide open by default.  RESTRICT THIS!**
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR block allowed to access SSH (port 22).  **CHANGE THIS TO YOUR SPECIFIC IP OR RANGE!**"
  default     = "0.0.0.0/0" # **DANGER: Wide open by default.  RESTRICT THIS!**
}


