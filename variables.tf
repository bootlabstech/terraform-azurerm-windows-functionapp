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