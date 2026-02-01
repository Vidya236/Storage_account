terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Changed from ~> 3.0 to ~> 4.0
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      # Changed from ~> 2.0 to ~> 3.0
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}
