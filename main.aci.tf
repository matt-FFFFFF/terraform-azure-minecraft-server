resource "random_id" "container_instance" {
  byte_length = 6
  prefix      = "aci"
}

resource "azapi_resource" "azure_container_instance" {
  type = "Microsoft.ContainerInstance/containerGroups@2023-05-01"
  body = {
    properties = {
      containers = [
        {
          name = "minecraft"
          properties = {
            environmentVariables = local.container_environment_variables,
            image                = var.container_image
            ports = [
              {
                port     = var.port
                protocol = "TCP"
              },
            ],
            volumeMounts = [
              {
                name      = "filesharevolume",
                mountPath = "/data"
              }
            ]
            resources = {
              requests = {
                cpu        = var.container_request_cpu
                memoryInGB = var.container_request_memory_in_gb
              }
            }
          }
        },
      ]
      ipAddress = {
        ports = [
          {
            port     = var.port
            protocol = "TCP"
          },
        ]
        type = "Public"
      }
      osType        = "Linux"
      restartPolicy = "Always"
      volumes = [
        {
          name = "filesharevolume",
          azureFile = {
            shareName          = local.file_share_name,
            storageAccountName = azapi_resource.storage_account.name,
            storageAccountKey  = local.storage_account_key1
          }
        }
      ]
    }
  }
  location               = var.location
  name                   = coalesce(var.container_instance_name, random_id.container_instance.hex)
  parent_id              = var.resource_group_resource_id
  response_export_values = ["properties.ipAddress.ip"]
}
