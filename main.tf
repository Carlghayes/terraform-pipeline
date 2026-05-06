terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "security_group" {
  source        = "./modules/security_group"
  name          = "terraform-sg"
  ingress_rules = var.ingress_rules
}

module "compute" {
  source            = "./modules/compute"
  ami               = var.ami
  instance_type     = var.instance_type
  ssh_public_key    = var.ssh_public_key
  security_group_id = module.security_group.security_group_id
  ingress_rules     = var.ingress_rules
}
