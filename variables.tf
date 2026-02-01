variable "resource_group_name" {
  type        = string
  description = "Name of the existing/new Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "East US"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique name for the Storage Account"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
}
