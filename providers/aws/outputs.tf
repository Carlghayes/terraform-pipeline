output "instance_public_ip" {
  description = "Public IP address of the provisioned instance"
  value       = module.compute.public_ip
}