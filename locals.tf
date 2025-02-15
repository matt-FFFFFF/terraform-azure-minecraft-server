locals {
  storage_account_key1 = sensitive(azapi_resource_action.storage_account_list_keys.output.keys[0].value)
  storage_account_key2 = sensitive(azapi_resource_action.storage_account_list_keys.output.keys[1].value)
}

locals {
  file_share_name = "minecraftdata"
}

locals {
  container_environment_variables = concat(
    [
      for key, value in var.minecraft_server_environment_variables : {
        name        = key
        value       = value
        secureValue = null
      }
    ],
    [
      for key, value in nonsensitive(var.minecraft_server_environment_variables_sensitive) : {
        name        = key
        value       = null
        secureValue = sensitive(value)
      }
    ]
  )
}

locals {
  log_analytics_workspace_primary_key   = sensitive(azapi_resource_action.log_analytics_workspace_keys.output.primarySharedKey)
  log_analytics_workspace_secondary_key = sensitive(azapi_resource_action.log_analytics_workspace_keys.output.secondarySharedKey)
}
