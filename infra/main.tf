# Azure Provider Configuration
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Data Source for Tenant Information
data "azurerm_client_config" "current" {}

# Resource Group
resource "azurerm_resource_group" "main" {
  name = "rg-${replace(var.environment, "/", "-")}-subscriptionservice"
  location = var.location
}

# Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  name = "subscriptionserviceplan-${replace(var.environment, "/", "-")}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux" # Specify 'Linux' or 'Windows' based on requirements
  sku_name            = "S1"    # Standard tier, S1 size
}

# Key Vault
resource "azurerm_key_vault" "key_vault" {
  name = "subservkv-${substr(replace(var.environment, "/", "-"), 0, 15)}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku_name  = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get", "List", "Set", "Delete"]
  }
}

# SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name = "subscriptionservicesqlserver-${substr(replace(var.environment, "/", "-"), 0, 15)}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "securepassword123!" # Replace with a secure password
}

# SQL Database
resource "azurerm_mssql_database" "sql_database" {
  name        = "subscriptionservicedb-${var.environment}"
  server_id   = azurerm_mssql_server.sql_server.id
  sku_name    = "S0" # Define the Standard performance tier
  max_size_gb = 10
}

# App Service
resource "azurerm_linux_web_app" "main" {
  name                = "subservappservice-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    always_on = true
  }

  app_settings = {
    "ENVIRONMENT" = var.environment
  }
}