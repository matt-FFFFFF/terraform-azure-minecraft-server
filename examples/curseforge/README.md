<!-- BEGIN_TF_DOCS -->
# Curseforge example

This example shows how to deploy a server with a modpack from Curseforge.
It also increases the view distance to 24 chunks.

**Make sure to change your OPS player name in the `ops` section.**

You can download this example to a local directory and run the following commands to deploy the server:

> You will need to be logged in to your Azure account and have the Azure CLI installed as well as Terraform.

```shell
terraform init
terraform apply
```

```hcl
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
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.9)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.2)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

## Resources

The following resources are used by this module:

- [azapi_resource.rg](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [random_id.rg](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

No outputs.

## Modules

The following Modules are called:

### <a name="module_minecraft_server"></a> [minecraft\_server](#module\_minecraft\_server)

Source: ../../

Version:

<!-- END_TF_DOCS -->