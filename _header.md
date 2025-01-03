# terraform-azure-minecraft-server

This is a Terraform module to deploy a Minecraft server on Azure.

## Features

- Azure Files for persistent storage
- Azure Container Instances for the server itself
- Uses the industry standard [`itzg/minecraft-server`](<https://docker-minecraft-server.readthedocs.io/en/latest/>) container image

## Design Principles

- Simple to use
- Cost effective

## Configuration

Most configuration is done via environment variables. See the [server properties](https://docker-minecraft-server.readthedocs.io/en/latest/configuration/server-properties/) for details.

```hcl
module "minecraft_server" {
  source                     = "matt-FFFFFF/minecraft-server/azure"
  version                    = "0.1.1" # change this to your required version
  resource_group_resource_id = "/subscriptions/..."
  location                   = "swedencentral"

  minecraft_server_environment_variables = {
    EULA          = "true"
    MEMORY        = "4G",
    DIFFICULTY    = "normal",
    SERVER_NAME   = "Minecraft Server",
    OPS           = "yourPlayerHandle"
    VIEW_DISTANCE = "32"
  }
}
```
