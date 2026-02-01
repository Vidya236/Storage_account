output "spn_id" {
  value = module.service_principal.client_id
}

output "spn_password" {
  value     = module.service_principal.client_secret
  sensitive = true
}

output "storage_account_id" {
  value = azurerm_storage_account.example.id
}
