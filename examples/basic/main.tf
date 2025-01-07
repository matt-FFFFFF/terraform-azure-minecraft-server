terraform {
  required_version = "~> 1.9"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

resource "random_id" "rg" {
  byte_length = 6
  prefix      = "rg"
}

resource "azapi_resource" "rg" {
  type     = "Microsoft.Resources/resourceGroups@2024-03-01"
  name     = random_id.rg.hex
  location = "swedencentral"

}

# When you copy this example, remove the source line with the relative path and
# uncomment the source lines with the registry path and version
module "minecraft_server" {
  source = "../../"
  # source                         = https://registry.terraform.io/modules/matt-FFFFFF/minecraft-server
  # version                        = "0.3.0"
  location                       = azapi_resource.rg.location
  resource_group_resource_id     = azapi_resource.rg.id
  container_request_memory_in_gb = 5
  minecraft_server_environment_variables = {
    DIFFICULTY    = "normal"
    EULA          = "true"
    MEMORY        = "4G"
    MODE          = "survival"
    OPS           = "yourPlayerHandle" # Set this to your Minecraft player handle to allow you to run admin commands in the server
    SERVER_NAME   = "Minecraft Server"
    VERSION       = "1.21.4" # This is the version of minecraft server
    VIEW_DISTANCE = "15"     # This is the view distance of the server in chunks, this is a sensible default btu can be increased if you have a powerful server
  }
}
