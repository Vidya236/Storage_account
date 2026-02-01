variable "resource_group_name" {
  type    = string
  default = "shared-app-rg" # This stops the RG prompt
}
variable "location" {
  type        = string
  description = "Azure region"
  default     = "South India"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
}
variable "storage_names" {
  type = map(string)
  default = {
    dev   = "vidyadevstore2026v1"
    stage = "vidyastagestore2026v1"
  }
}




