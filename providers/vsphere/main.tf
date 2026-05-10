terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.0"
    }
  }
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = true
}

# TODO: Add module calls once modules/vsphere/ is implemented
# module "security_group" {
#   source        = "../../modules/vsphere/security_group"
#   name          = "terraform-sg"
#   ingress_rules = var.ingress_rules
# }

# module "compute" {
#   source         = "../../modules/vsphere/compute"
#   ssh_public_key = var.ssh_public_key
#   ingress_rules  = var.ingress_rules
# }