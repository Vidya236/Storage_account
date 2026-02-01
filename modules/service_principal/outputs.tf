output "client_id" {
  description = "The Application (Client) ID"
  value       = azuread_application.this.client_id
}

output "service_principal_object_id" {
  description = "The Object ID of the Service Principal"
  value       = azuread_service_principal.this.object_id
}

output "client_secret" {
  description = "The Password/Secret for the Service Principal"
  value       = azuread_service_principal_password.this.value
  sensitive   = true
}
output "application_object_id" {
  value = azuread_application.this.object_id
}
# Add or change this output
output "application_id" {
  description = "The Application ID of the Azure AD App"
  value       = azuread_application.this.application_id
}

