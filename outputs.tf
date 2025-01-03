output "container_public_ip_address" {
  value       = azapi_resource.azure_container_instance.output.properties.ipAddress.ip
  description = "The public IP address of the Minecraft server container."
}
