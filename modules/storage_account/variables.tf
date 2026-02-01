variable "rg_name" {
  description ="storage_rg"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sa_name" {
  description = "Globally unique name for the storage account"
  type        = string
}
variable "account_tier" {
  description = "Tier of storage (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = { environment = "default" }
}
