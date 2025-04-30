resource "azurerm_storage_account" "example" {
  name                     = "${var.name}stg"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  allow_nested_items_to_be_public = var.allow_nested_items_tobe_public
  public_network_access_enabled = var.public_network_access_enabled
  
}

resource "azurerm_service_plan" "example" {
  name                = "${var.name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
  depends_on = [ azurerm_storage_account.example ]
}


resource "azurerm_windows_function_app" "example" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id
  virtual_network_subnet_id  = var.virtual_network_subnet_id

  builtin_logging_enabled     = var.builtin_logging_enabled
  daily_memory_time_quota     = var.daily_memory_time_quota

  app_settings = {
    "AzureBlobStorage:BlobConnectionString"  = var.blob_connection_string
    "AzureBlobStorage:BlobContainerName"     = var.blob_container_name
    "AzureWebJobs.QueueTrigger.Disabled"     = var.AzureWebJobs_QueueTrigger_Disabled
    "FUNCTIONS_INPROC_NET8_ENABLED"          = "1"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"         = "1"
    "WEBSITE_USE_PLACEHOLDER_DOTNETISOLATED" = "1"
  }

  site_config {
    ftps_state                           = var.ftps_state
    app_command_line                     = var.app_command_line
    app_scale_limit                      = var.app_scale_limit
    vnet_route_all_enabled               = var.vnet_route_all_enabled
    runtime_scale_monitoring_enabled     = var.runtime_scale_monitoring_enabled
    use_32_bit_worker                    = var.use_32_bit_worker
    application_insights_connection_string = var.app_insights_conn_string != "" ? var.app_insights_conn_string : null
    application_insights_key               = var.app_insights_key != "" ? var.app_insights_key : null

  }

  connection_string {
    name  = var.sql_data_connect
    type  = "SQLAzure"
    value = var.sql_connection_string
  }

  sticky_settings {
    app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "AzureBlobStorage:BlobConnectionString",
      "AzureBlobStorage:BlobContainerName",
      "AzureWebJobsStorage",
      "BlobConnectionString",
      "BlobContainerName",
    ]
    connection_string_names = [var.sql_data_connect]
  }

  tags = {}

  depends_on = [azurerm_service_plan.example]
  
  lifecycle {
    ignore_changes = [
      app_settings,
      site_config,
      sticky_settings,
      tags
    ]
  }
}