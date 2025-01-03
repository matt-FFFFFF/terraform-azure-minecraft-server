resource "random_id" "storage_account" {
  byte_length = 6
  prefix      = "stg"
}

resource "azapi_resource" "storage_account" {
  type      = "Microsoft.Storage/storageAccounts@2023-05-01"
  parent_id = var.resource_group_resource_id
  name      = coalesce(var.storage_account_name, random_id.storage_account.hex)
  location  = var.location
  body = {
    kind = "StorageV2"
    properties = {
      accessTier                   = "Hot"
      allowSharedKeyAccess         = true
      defaultToOAuthAuthentication = false
      isHnsEnabled                 = false
      isNfsV3Enabled               = false
      isSftpEnabled                = false
      minimumTlsVersion            = "TLS1_2"
      networkAcls = {
        defaultAction = "Allow"
      }
      publicNetworkAccess      = "Enabled"
      supportsHttpsTrafficOnly = true
    }
    sku = {
      name = "Standard_LRS"
    }
  }
}

resource "azapi_resource" "file_share" {
  type      = "Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01"
  parent_id = "${azapi_resource.storage_account.id}/fileServices/default"
  name      = local.file_share_name
  body = {
    properties = {
      enabledProtocols = "SMB"
      shareQuota       = 5
    }
  }
}

resource "azapi_resource_action" "storage_account_list_keys" {
  type                   = "Microsoft.Storage/storageAccounts@2023-05-01"
  action                 = "listKeys"
  method                 = "POST"
  resource_id            = azapi_resource.storage_account.id
  response_export_values = ["keys"]
}
