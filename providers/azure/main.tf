terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# TODO: Add module calls once modules/azure/ is implemented
# module "security_group" {
#   source        = "../../modules/azure/security_group"
#   name          = "terraform-sg"
#   ingress_rules = var.ingress_rules
# }

# module "compute" {
#   source            = "../../modules/azure/compute"
#   vm_size           = var.vm_size
#   ssh_public_key    = var.ssh_public_key
#   security_group_id = module.security_group.security_group_id
#   ingress_rules     = var.ingress_rules
# }