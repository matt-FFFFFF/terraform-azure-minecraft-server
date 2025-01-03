variable "container_image" {
  description = "The image to use for the Minecraft server container. This should be based on the `itzg/minecraft-server` image."
  type        = string
  default     = "docker.io/itzg/minecraft-server"
  nullable    = false
}

variable "container_request_cpu" {
  description = "The number of CPU cores to request for the Minecraft server container."
  type        = number
  default     = 2
  nullable    = false
}

variable "container_request_memory_in_gb" {
  description = "The amount of memory in GB to request for the Minecraft server container."
  type        = number
  default     = 5
  nullable    = false
}


variable "storage_account_name" {
  description = "The name of the storage account. Leave as `null` to use the an auto-generated name."
  type        = string
  default     = null
}

variable "container_instance_name" {
  description = "The name of the container instance. Leave as `null` to use the an auto-generated name."
  type        = string
  default     = null
}

variable "location" {
  description = "The location of the resources."
  type        = string
  nullable    = false
}

variable "resource_group_resource_id" {
  type        = string
  description = "The full id of the resource group in which to deploy the resources."
  nullable    = false
}

variable "minecraft_server_environment_variables" {
  type = map(string)
  default = {
    EULA = "true"
  }
  nullable    = false
  description = <<DESCRIPTION
A map of environment variables to pass to the Minecraft server container.
The key is the name of the environment variable, and the value is the value of the environment variable.

For the container to work, you must include the `EULA` environment variable with the value `true`.
See <https://docker-minecraft-server.readthedocs.io/en/latest/configuration/server-properties/> for more information.
DESCRIPTION
}

variable "minecraft_server_environment_variables_sensitive" {
  type        = map(string)
  default     = {}
  nullable    = false
  sensitive   = true
  description = "A map of sensitive environment variables to pass to the Minecraft server container. The key is the name of the environment variable, and the value is the value of the environment variable."
}

variable "port" {
  type        = number
  default     = 25565
  nullable    = false
  description = "The port on which to expose the Minecraft server."
}
