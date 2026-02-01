variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  type        = string
}

variable "rg_name" {
  type        = string
}

variable "storage_account_key" {
  description = "The secret value to store (passed from storage module)"
  type        = string
  sensitive   = true
}

variable "managed_identity_principal_id" {
  description = "The Principal ID of the identity that needs access to secrets"
  type        = string
}
variable "admin_object_id" {
  type        = string
  description = "The Object ID of the user who needs to manage secrets"
  default     = "" # Optional: leave empty if not needed
}
