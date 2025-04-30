variable "resource_group_name" {
  type = string

}
variable "location" {
  type = string

}
variable "name" {
  type = string

}
variable "account_tier" {
  type    = string
  default = "Standard"

}
variable "account_replication_type" {
  type    = string
  default = "LRS"

}
variable "allow_nested_items_tobe_public" {
  type = bool
  default = false
}
variable "public_network_access_enabled" {
  type = bool
  default = false
}
variable "AzureWebJobs_QueueTrigger_Disabled" {
  type = bool
  default = false  
}
variable "builtin_logging_enabled" {
  type = bool
  default = false
}
variable "daily_memory_time_quota" {
  type = number
  default = 2 
}
variable "blob_connection_string" {
  type = string
}
variable "blob_container_name" {
  type = string
}
variable "runtime_scale_monitoring_enabled" {
  type = bool
  default = true
}
variable "app_insights_key" {
  type = string
  default = ""
  sensitive = true
}
variable "app_insights_conn_string" {
  type = string
  default = ""
  sensitive = true
}
variable "use_32_bit_worker" {
  type = bool
  default = false

}
variable "sql_connection_string" {
  type = string
  sensitive = true
  
}
variable "sql_data_connect" {
  type = string
  sensitive = true

}
variable "os_type" {
  type    = string
  default = "Windows"

}
variable "sku_name" {
  type    = string
  default = "Y1"

}
variable "ftps_state" {
  type    = string
  default = "FtpsOnly"

}
variable "app_command_line" {
  type    = string
  default = ""

}
variable "app_scale_limit" {
  type    = number
  default = 1

}
variable "vnet_route_all_enabled" {
  type    = bool
  default = false

}
variable "virtual_network_subnet_id" {
  type = string
  
}