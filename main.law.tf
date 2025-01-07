resource "random_id" "log_analytics_workspace_name" {
  byte_length = 6
  prefix      = "law"
}

resource "azapi_resource" "log_analytics_workspace" {
  type      = "Microsoft.OperationalInsights/workspaces@2023-09-01"
  parent_id = var.resource_group_resource_id
  name      = random_id.log_analytics_workspace_name.hex
  location  = var.location
  body = {
    properties = {
      features = {
        immediatePurgeDataOn30Days = true
      }
      publicNetworkAccessForQuery     = "Enabled"
      publicNetworkAccessForIngestion = "Enabled"
      retentionInDays                 = 30
      sku = {
        name = "PerGB2018"
      }
    }
  }
  response_export_values = ["properties.customerId"]
}

resource "azapi_resource_action" "log_analytics_workspace_keys" {
  resource_id            = azapi_resource.log_analytics_workspace.id
  type                   = "Microsoft.OperationalInsights/workspaces@2023-09-01"
  action                 = "sharedKeys"
  method                 = "POST"
  response_export_values = ["*"]
}
