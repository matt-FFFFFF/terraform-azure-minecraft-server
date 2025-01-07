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
  container_request_memory_in_gb = 9
  minecraft_server_environment_variables = {
    CF_PAGE_URL   = "https://www.curseforge.com/minecraft/modpacks/the-vanilla-experience/files/5967958" # This is the URL of the modpack you want to install
    DIFFICULTY    = "normal",
    EULA          = "true"
    MEMORY        = "6G", # If you have a lot of mods, you may need to increase this value, and also the memory allocated to the container
    MODE          = "survival",
    OPS           = "yourPlayerHandle" # Set this to your Minecraft player handle to allow you to run admin commands in the server
    SERVER_NAME   = "Minecraft Server",
    TYPE          = "AUTO_CURSEFORGE" # This tells the module to install the modpack from CurseForge and to detect the server type automatically
    VERSION       = "1.21.4"          # This is the version of minecraft server
    VIEW_DISTANCE = "24"              # This is the view distance of the server in chunks, this is quite high and may need to be lowered depending on the server performance
  }
}
