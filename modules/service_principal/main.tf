data "azuread_client_config" "current" {}

# 1. Create the Azure AD Application
resource "azuread_application" "this" {
  display_name = var.sp_name
}

# 2. Create the Service Principal
resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
}

# 3. Create a Password (Secret)
resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
}

# 4. Assign "Storage Blob Data Contributor" to the existing Storage Account
resource "azurerm_role_assignment" "storage_access" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.this.object_id
}
