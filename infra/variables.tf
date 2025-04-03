variable "resource_group_name" {
  description = "Name of the Resource Group"
  default     = "StartupRG"
}

variable "location" {
  description = "Azure region for resources"
  default     = "Australia East"
}

variable "app_service_plan_name" {
  description = "App Service Plan name"
  default     = "StartupAppServicePlan"
}

variable "app_name" {
  description = "Web App name"
  default     = "StartupAppService"
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
  default     = "startupdb"
}

variable "admin_username" {
  description = "Database admin username"
  default     = "adminuser"
}

variable "admin_password" {
  description = "Database admin password"
  default     = null
}

variable "common_tags" {
  description = "Tags for Azure resources"
  default     = {
    Environment = "Startup"
    Owner       = "Pradyumna"
  }
}