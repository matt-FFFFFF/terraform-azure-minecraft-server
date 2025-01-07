<!-- BEGIN_TF_DOCS -->
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
  version                    = "..." # Change this to your desired version <https://developer.hashicorp.com/terraform/language/expressions/version-constraints>
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

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.9)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.2)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

## Resources

The following resources are used by this module:

- [azapi_resource.container_instance](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.file_share](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.log_analytics_workspace](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.storage_account](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource_action.log_analytics_workspace_keys](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource_action) (resource)
- [azapi_resource_action.storage_account_list_keys](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource_action) (resource)
- [random_id.container_dns_prefix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [random_id.container_instance](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [random_id.log_analytics_workspace_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [random_id.storage_account](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_location"></a> [location](#input\_location)

Description: The location of the resources.

Type: `string`

### <a name="input_resource_group_resource_id"></a> [resource\_group\_resource\_id](#input\_resource\_group\_resource\_id)

Description: The full id of the resource group in which to deploy the resources.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_container_dns_prefix"></a> [container\_dns\_prefix](#input\_container\_dns\_prefix)

Description: The DNS prefix to use for the container instance. Leave as `null` to use the an auto-generated name.

Type: `string`

Default: `null`

### <a name="input_container_image"></a> [container\_image](#input\_container\_image)

Description: The image to use for the Minecraft server container. This should be based on the `itzg/minecraft-server` image.

Type: `string`

Default: `"docker.io/itzg/minecraft-server"`

### <a name="input_container_instance_name"></a> [container\_instance\_name](#input\_container\_instance\_name)

Description: The name of the container instance. Leave as `null` to use the an auto-generated name.

Type: `string`

Default: `null`

### <a name="input_container_request_cpu"></a> [container\_request\_cpu](#input\_container\_request\_cpu)

Description: The number of CPU cores to request for the Minecraft server container.

Type: `number`

Default: `2`

### <a name="input_container_request_memory_in_gb"></a> [container\_request\_memory\_in\_gb](#input\_container\_request\_memory\_in\_gb)

Description: The amount of memory in GB to request for the Minecraft server container.

Type: `number`

Default: `5`

### <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name)

Description: The name of the log analytics workspace. Leave as `null` to use the an auto-generated name.

Type: `string`

Default: `null`

### <a name="input_minecraft_server_environment_variables"></a> [minecraft\_server\_environment\_variables](#input\_minecraft\_server\_environment\_variables)

Description: A map of environment variables to pass to the Minecraft server container.  
The key is the name of the environment variable, and the value is the value of the environment variable.

For the container to work, you must include the `EULA` environment variable with the value `true`.  
See <https://docker-minecraft-server.readthedocs.io/en/latest/configuration/server-properties/> for more information.

Type: `map(string)`

Default:

```json
{
  "EULA": "true"
}
```

### <a name="input_minecraft_server_environment_variables_sensitive"></a> [minecraft\_server\_environment\_variables\_sensitive](#input\_minecraft\_server\_environment\_variables\_sensitive)

Description: A map of sensitive environment variables to pass to the Minecraft server container. The key is the name of the environment variable, and the value is the value of the environment variable.

Type: `map(string)`

Default: `{}`

### <a name="input_port"></a> [port](#input\_port)

Description: The port on which to expose the Minecraft server.

Type: `number`

Default: `25565`

### <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name)

Description: The name of the storage account. Leave as `null` to use the an auto-generated name.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_container_public_fqdn_and_port"></a> [container\_public\_fqdn\_and\_port](#output\_container\_public\_fqdn\_and\_port)

Description: The public FQDN of the Minecraft server.

### <a name="output_container_public_ip_address_and_port"></a> [container\_public\_ip\_address\_and\_port](#output\_container\_public\_ip\_address\_and\_port)

Description: The public IP address and port number of the Minecraft server.

## Modules

No modules.

<!-- END_TF_DOCS -->