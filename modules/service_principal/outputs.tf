output "client_id" {
  description = "The Application (Client) ID (Raw UUID)"
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
  description = "The Internal Object ID of the App Registration"
  value       = azuread_application.this.object_id
}

# This is the critical output for your root main.tf
output "application_id" {
  description = "The Full Resource ID needed for the password resource (Path format)"
  # We use .id here to get the "/applications/..." format Terraform 3.0+ expects
  value       = azuread_application.this.id
}
