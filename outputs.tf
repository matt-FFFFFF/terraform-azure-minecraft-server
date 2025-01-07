output "container_public_ip_address_and_port" {
  description = "The public IP address and port number of the Minecraft server."
  value       = "${azapi_resource.container_instance.output.properties.ipAddress.ip}:${var.port}"
}

output "container_public_fqdn_and_port" {
  description = "The public FQDN of the Minecraft server."
  value       = "${azapi_resource.container_instance.output.properties.ipAddress.fqdn}:${var.port}"
}
