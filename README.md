<!-- BEGIN_TF_DOCS -->
# terraform-azure-minecraft-server

This is a Terraform module to deploy a Minecraft server on Azure.

Features:

- Azure Files for persistent storage
- Azure Container Instances for the server itself
- Uses the industry standard [`itzg/minecraft-server`](<https://docker-minecraft-server.readthedocs.io/en/latest/>) container image

It has been designed to be very simple to use.

## Configuration

Most configuration is done via environment variables. See the [server properties](https://docker-minecraft-server.readthedocs.io/en/latest/configuration/server-properties/) for details.

```hcl
module "minecraft_server" {
  source = "github.com/matt-FFFFFF/terraform-azure-minecraft-server"

}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.10)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.2)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6)

## Resources

The following resources are used by this module:

- [azapi_resource.azure_container_instance](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.file_share](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.storage_account](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource_action.storage_account_list_keys](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource_action) (resource)
- [random_id.container_instance](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
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

### <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name)

Description: The name of the storage account. Leave as `null` to use the an auto-generated name.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_container_public_ip_address"></a> [container\_public\_ip\_address](#output\_container\_public\_ip\_address)

Description: The public IP address of the Minecraft server container.

## Modules

No modules.

<!-- END_TF_DOCS -->