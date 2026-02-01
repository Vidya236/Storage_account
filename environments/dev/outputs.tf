# ~/Storage_account/environments/dev/outputs.tf

output "dev_sa_url" {
  description = "Primary Blob Endpoint for the Dev Storage Account"
  value       = module.dev_storage.primary_blob_endpoint
}

output "dev_key_vault_uri" {
  description = "The URI of the Dev Key Vault"
  value       = module.dev_key_vault.vault_uri
}

output "dev_managed_identity_id" {
  description = "The Client ID for the App's Managed Identity"
  value       = module.dev_storage.managed_identity_client_id
}

output "dev_storage_secret_name" {
  description = "The name of the secret containing the storage key"
  value       = "storage-primary-access-key"
}
