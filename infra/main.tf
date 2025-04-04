# Azure Provider Configuration
provider "azurerm" {
  features {}
  subscription_id = "26801b16-02f0-458e-8e42-863e8c56e2f8"
}

# Data Source for Tenant Information
data "azurerm_client_config" "current" {}

# Resource Group
resource "azurerm_resource_group" "subscription_rg" {
  name     = "subscriptionservicerg"
  location = "East US" # Update to your preferred Azure region
}

# Service Plan (Corrected)
resource "azurerm_service_plan" "app_service_plan" {
  name                = "subscriptionserviceplan"
  resource_group_name = azurerm_resource_group.subscription_rg.name
  location            = azurerm_resource_group.subscription_rg.location
  os_type             = "Linux" # Specify 'Linux' or 'Windows' based on requirements
  sku_name            = "S1"    # Standard tier, S1 size
}

# Key Vault (Corrected)
resource "azurerm_key_vault" "key_vault" {
  name                = "subservicevault"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.subscription_rg.name

  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get", "List", "Set", "Delete"]
  }
}

# SQL Server (Corrected)
resource "azurerm_mssql_server" "sql_server" {
  name                         = "subscriptionservicesqlserver"
  resource_group_name          = azurerm_resource_group.subscription_rg.name
  location                     = azurerm_resource_group.subscription_rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "securepassword123!" # Ensure secure password
}

# SQL Database (Corrected)
resource "azurerm_mssql_database" "sql_database" {
  name        = "subscriptionservicedb"
  server_id   = azurerm_mssql_server.sql_server.id
  sku_name    = "S0" # Define the Standard performance tier
  max_size_gb = 10
}