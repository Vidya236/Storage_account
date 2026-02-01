# This refers to your existing Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Fixed Storage Account (Updated deprecated property)
resource "azurerm_storage_account" "example" {
  name                      = var.storage_names[terraform.workspace]
  resource_group_name       = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  # UPDATED: Changed from enable_https_traffic_only
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  tags = {
    environment = terraform.workspace
  }
}
# This creates the "bucket" inside your storage account
resource "azurerm_storage_container" "data" {
  name                  = "data-container"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

# Linking the Service Principal module
module "service_principal" {
  source             = "./modules/service_principal"
  sp_name            = "vidya-${terraform.workspace}-identity"
  storage_account_id = azurerm_storage_account.example.id
}

# FIXED: Points to the object_id inside the module
resource "azuread_application_password" "example" {
  application_object_id = module.service_principal.application_id
  display_name          = "terraform-generated-secret"
  end_date              = "17520h"
}

output "client_secret" {
  value     = azuread_application_password.example.value
  sensitive = true
}
