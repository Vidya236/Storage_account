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
module "dev_storage" {
  source   = "../../modules/storage_account"
  rg_name  = data.azurerm_resource_group.shared.name # Pass the name
  location = data.azurerm_resource_group.shared.location
  sa_name  = "vidyadevstore2026v1" # Must be unique
  kv_name      = "vidyadev-kv-2026" # Key Vault names must be unique
  account_tier = "Standard"
  tags = {
    environment = "dev"
  }
}

module "dev_key_vault" {
  source                       = "../../modules/key_vault"
  kv_name                      = "vidyadev-kv-2026"
  rg_name                      = data.azurerm_resource_group.shared.name
  location                     = data.azurerm_resource_group.shared.location
  storage_account_key          = module.dev_storage.primary_access_key
  managed_identity_principal_id = module.dev_storage.identity_principal_id
}
