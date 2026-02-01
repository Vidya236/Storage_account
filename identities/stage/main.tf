# 1. Look up the existing Stage Storage Account
data "azurerm_storage_account" "stage_sa" {
  name                = "vidyastagestore2026v1"
  resource_group_name = "shared-app-rg"
}

# 2. Look up the existing Stage Key Vault
data "azurerm_key_vault" "stage_kv" {
  name                = "vidyastage-kv-2026"
  resource_group_name = "shared-app-rg"
}

# 3. Create the Service Principal using the shared module
module "stage_sp" {
  source             = "../../modules/service_principal"
  sp_name            = "sp-stage-vidya-app"
  storage_account_id = data.azurerm_storage_account.stage_sa.id
}

# 4. Save Client ID to Stage Key Vault
resource "azurerm_key_vault_secret" "sp_client_id" {
  name         = "sp-client-id"
  value        = module.stage_sp.client_id
  key_vault_id = data.azurerm_key_vault.stage_kv.id
}

# 5. Save Client Secret to Stage Key Vault
resource "azurerm_key_vault_secret" "sp_client_secret" {
  name         = "sp-client-secret"
  value        = module.stage_sp.client_secret
  key_vault_id = data.azurerm_key_vault.stage_kv.id
}
