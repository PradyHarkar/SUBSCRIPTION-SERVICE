# Provider Configuration
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# App Service Plan (Cost-Effective SKU: Free Tier F1)
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier     = "Free"
    size     = "F1"
    capacity = 1
  }
}

# Web App
resource "azurerm_app_service" "app_service" {
  name                = var.app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    linux_fx_version = var.runtime_stack
  }

  tags = var.common_tags
}

# Key Vault (for storing sensitive data)
resource "azurerm_key_vault" "key_vault" {
  name                = "${var.resource_group_name}-vault"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku {
    name = "standard"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    permissions {
      secrets = ["get", "list", "set", "delete"]
    }
  }

  tags = var.common_tags
}

# SQL Database (Basic Tier)
resource "azurerm_sql_server" "sql_server" {
  name                         = var.db_server_name
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
}

resource "azurerm_sql_database" "sql_database" {
  name                = var.db_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sql_server.name

  sku {
    name = "Basic"
    tier = "Basic"
    capacity = 5
  }

  tags = var.common_tags
}

# Output Variables
output "app_service_url" {
  value = azurerm_app_service.app_service.default_site_hostname
}

output "key_vault_name" {
  value = azurerm_key_vault.key_vault.name
}

output "sql_server_url" {
  value = azurerm_sql_server.sql_server.fully_qualified_domain_name
}