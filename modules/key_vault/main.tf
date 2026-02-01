# modules/key_vault/main.tf

# This fetches the context of the person or service principal running the terraform commands
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.rg_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7

  # Best Practice: We leave access_policy blocks out of this resource
  # and use separate azurerm_key_vault_access_policy resources instead.
}

resource "azurerm_key_vault_secret" "storage_key" {
  name         = "storage-primary-access-key"
  value        = var.storage_account_key
  key_vault_id = azurerm_key_vault.this.id

  # Ensure permissions are in place before trying to create the secret
  depends_on = [azurerm_key_vault_access_policy.admin_user]
}

# 1. Policy for the Managed Identity (The Application/Storage Identity)
resource "azurerm_key_vault_access_policy" "identity_policy" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.managed_identity_principal_id

  secret_permissions = [
    "Get",
    "Set",
    "List"
  ]
}

# 2. Policy for YOU (The Admin/Deployer)
# This allows you to run 'az keyvault secret show' without manual setup
resource "azurerm_key_vault_access_policy" "admin_user" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge",
    "Recover"
  ]
