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
  virtual_network_subnet_id = var.virtual_network_subnet_id

  site_config {
    ftps_state             = var.ftps_state
    app_command_line       = var.app_command_line
    app_scale_limit        = var.app_scale_limit
    vnet_route_all_enabled = var.vnet_route_all_enabled
  }

  depends_on = [ azurerm_service_plan.example ]
  
  lifecycle {
    ignore_changes = [
      tags,
      app_settings,
      connection_string,
      site_config.0.application_insights_connection_string,
      site_config.0.application_insights_key,
      sticky_settings,
    ] 
  }
}