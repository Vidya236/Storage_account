output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}
output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for the storage account"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_access_key" {
  description = "The storage access key (required for the KV secret)"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "managed_identity_client_id" {
  description = "The Client ID of the Managed Identity"
  value       = azurerm_user_assigned_identity.this.client_id
}

output "identity_principal_id" {
  description = "The Principal ID (required for the KV access policy)"
  value       = azurerm_user_assigned_identity.this.principal_id
}
