variable "ssh_public_key" {
  description = "SSH public key to provision on the instance"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources in"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "terraform-rg"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "ingress_rules" {
  description = "List of inbound port rules for the security group"
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    { port = 22,  protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "SSH" },
    { port = 80,  protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTP" },
    { port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTPS" }
  ]
}