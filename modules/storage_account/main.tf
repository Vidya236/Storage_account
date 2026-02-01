# 1. Look up current client info for Key Vault permissions
data "azurerm_client_config" "current" {}

# 2. Storage Account Resource
resource "azurerm_storage_account" "this" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = "LRS"
  tags                     = var.tags
}

# 3. Storage Container
resource "azurerm_storage_container" "this" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

# 4. User Assigned Managed Identity
resource "azurerm_user_assigned_identity" "this" {
  name                = "${var.sa_name}-identity"
  location            = var.location
  resource_group_name = var.rg_name
}
