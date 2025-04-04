variable "resource_group_name" {
  description = "Name of the Resource Group"
  default     = "SubservRG"
}

variable "location" {
  description = "Azure region for resources"
  default     = "Australia East"
}

variable "app_service_plan_name" {
  description = "App Service Plan name"
  default     = "SubservAppServPlan"
}

variable "app_name" {
  description = "Web App name"
  default     = "SubServApp"
}

variable "runtime_stack" {
  description = "Runtime stack for the Web App"
  default     = "NODE|16-lts"
}

variable "db_server_name" {
  description = "Database server name"
  default     = "startupdbserver"
}

variable "db_name" {
  description = "Database name"
  default     = "subserviceDB"
}

variable "admin_username" {
  description = "Database admin username"
  default     = "adminuser"
}

variable "admin_password" {
  description = "Database admin password"
  default     = "DevDBKVChange1!"
}

variable "common_tags" {
  description = "Tags for Azure resources"
  default     = {
    Environment = "Dev"
    Owner       = "Pradyumna"
  }
}