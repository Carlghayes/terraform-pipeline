resource "aws_key_pair" "this" {
  key_name   = "terraform-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [var.security_group_id]
  user_data              = templatefile("${path.module}/cloud-init.yml.tpl", {
    ssh_public_key = var.ssh_public_key
    ingress_rules  = var.ingress_rules
  })


  tags = {
    Name = "terraform-ubuntu"
  }
}