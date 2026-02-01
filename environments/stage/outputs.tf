output "stage_sa_url" {
  description = "Primary Blob Endpoint for the Stage Storage Account"
  value       = module.stage_storage_account.primary_blob_endpoint
}

output "stage_key_vault_uri" {
  description = "The URI of the Stage Key Vault"
  value       = module.stage_key_vault.vault_uri
}

output "stage_managed_identity_id" {
  description = "The Client ID for the Stage App's Managed Identity"
  value       = module.stage_storage_account.managed_identity_client_id
}

output "stage_storage_secret_name" {
  description = "The name of the secret in Stage Key Vault"
  value       = "storage-primary-access-key"
}
