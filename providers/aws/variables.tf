variable "ssh_public_key" {
  description = "SSH public key to provision on the instance"
  type        = string
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

variable "ami" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}