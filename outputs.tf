output "container_public_ip_address_and_port" {
  description = "The public IP address and port number of the Minecraft server."
  value       = "${azapi_resource.azure_container_instance.output.properties.ipAddress.ip}:${var.port}"
}
