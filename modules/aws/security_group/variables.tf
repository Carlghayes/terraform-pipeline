variable "name" {
  description = "Name tag for the security group"
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
}