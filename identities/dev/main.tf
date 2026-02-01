# 1. Look up the existing Dev Storage Account
data "azurerm_storage_account" "dev_sa" {
  name                = "vidyadevstore2026v1"
  resource_group_name = "shared-app-rg"
}

# 2. Look up the existing Dev Key Vault
data "azurerm_key_vault" "dev_kv" {
  name                = "vidyadev-kv-2026"
  resource_group_name = "shared-app-rg"
}

# 3. Create the Service Principal
module "dev_sp" {
  source             = "../../modules/service_principal"
  sp_name            = "sp-dev-vidya-app"
  storage_account_id = data.azurerm_storage_account.dev_sa.id
}

# 4. Save Client ID to Key Vault
resource "azurerm_key_vault_secret" "sp_client_id" {
  name         = "sp-client-id"
  value        = module.dev_sp.client_id
  key_vault_id = data.azurerm_key_vault.dev_kv.id
}

# 5. Save Client Secret to Key Vault
resource "azurerm_key_vault_secret" "sp_client_secret" {
  name         = "sp-client-secret"
  value        = module.dev_sp.client_secret
  key_vault_id = data.azurerm_key_vault.dev_kv.id
}
