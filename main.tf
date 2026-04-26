# Tell Terraform to use AWS as the provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Set the AWS region
provider "aws" {
  region = "us-east-1"
}

# SSH public key passed in as a variable
variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

# Upload your public SSH key to AWS
resource "aws_key_pair" "main" {
  key_name   = "terraform-key"
  public_key = var.ssh_public_key
}

# Security group — controls what traffic is allowed in and out
resource "aws_security_group" "main" {
  name        = "terraform-sg"
  description = "Allow SSH, HTTP, and HTTPS"

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# The Ubuntu EC2 instance
resource "aws_instance" "main" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.main.key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data              = file("cloud-init.yml")

  tags = {
    Name = "terraform-ubuntu"
  }
}