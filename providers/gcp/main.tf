terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

# TODO: Add module calls once modules/gcp/ is implemented
# module "security_group" {
#   source        = "../../modules/gcp/security_group"
#   name          = "terraform-sg"
#   ingress_rules = var.ingress_rules
# }

# module "compute" {
#   source            = "../../modules/gcp/compute"
#   machine_type      = var.machine_type
#   ssh_public_key    = var.ssh_public_key
#   security_group_id = module.security_group.security_group_id
#   ingress_rules     = var.ingress_rules
# }