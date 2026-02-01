terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0"
    }
  }
  backend "azurerm" {} # Configured via backend.conf
}

provider "azurerm" {
  features {}
}
data "azurerm_resource_group" "shared" {
  name = "shared-app-rg"
}
module "stage_storage_account" {
  source   = "../../modules/storage_account"
  rg_name  = data.azurerm_resource_group.shared.name
  location = data.azurerm_resource_group.shared.location
  sa_name  = "vidyastagestore2026v1" # Must be unique
  kv_name      = "vidyastage-kv-2026"
  account_tier = "Premium"
  tags = {
    environment = "stage"
  }
}
# --- Key Vault Module ---
module "stage_key_vault" {
  source                        = "../../modules/key_vault"
  kv_name                       = "vidyastage-kv-2026"
  rg_name                       = data.azurerm_resource_group.shared.name
  location                      = data.azurerm_resource_group.shared.location
  storage_account_key           = module.stage_storage_account.primary_access_key
  managed_identity_principal_id = module.stage_storage_account.identity_principal_id
}
