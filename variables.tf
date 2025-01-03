variable "location" {
  type        = string
  description = "The location of the resources."
  nullable    = false
}

variable "resource_group_resource_id" {
  type        = string
  description = "The full id of the resource group in which to deploy the resources."
  nullable    = false
}

variable "container_image" {
  type        = string
  default     = "docker.io/itzg/minecraft-server"
  description = "The image to use for the Minecraft server container. This should be based on the `itzg/minecraft-server` image."
  nullable    = false
}

variable "container_instance_name" {
  type        = string
  default     = null
  description = "The name of the container instance. Leave as `null` to use the an auto-generated name."
}

variable "container_request_cpu" {
  type        = number
  default     = 2
  description = "The number of CPU cores to request for the Minecraft server container."
  nullable    = false
}

variable "container_request_memory_in_gb" {
  type        = number
  default     = 5
  description = "The amount of memory in GB to request for the Minecraft server container."
  nullable    = false
}

variable "minecraft_server_environment_variables" {
  type = map(string)
  default = {
    EULA = "true"
  }
  description = <<DESCRIPTION
A map of environment variables to pass to the Minecraft server container.
The key is the name of the environment variable, and the value is the value of the environment variable.

For the container to work, you must include the `EULA` environment variable with the value `true`.
See <https://docker-minecraft-server.readthedocs.io/en/latest/configuration/server-properties/> for more information.
DESCRIPTION
  nullable    = false
}

variable "minecraft_server_environment_variables_sensitive" {
  type        = map(string)
  default     = {}
  description = "A map of sensitive environment variables to pass to the Minecraft server container. The key is the name of the environment variable, and the value is the value of the environment variable."
  nullable    = false
  sensitive   = true
}

variable "port" {
  type        = number
  default     = 25565
  description = "The port on which to expose the Minecraft server."
  nullable    = false
}

variable "storage_account_name" {
  type        = string
  default     = null
  description = "The name of the storage account. Leave as `null` to use the an auto-generated name."
}
