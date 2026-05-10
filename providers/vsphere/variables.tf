variable "ssh_public_key" {
  description = "SSH public key to provision on the instance"
  type        = string
}

variable "vsphere_server" {
  description = "vCenter server hostname or IP"
  type        = string
}

variable "vsphere_user" {
  description = "vCenter username"
  type        = string
}

variable "vsphere_password" {
  description = "vCenter password"
  type        = string
  sensitive   = true
}

variable "datacenter" {
  description = "vSphere datacenter name"
  type        = string
}

variable "datastore" {
  description = "vSphere datastore name"
  type        = string
}

variable "network" {
  description = "vSphere network name"
  type        = string
}

variable "host" {
  description = "vSphere host name"
  type        = string
}

variable "ingress_rules" {
  description = "List of inbound port rules"
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