terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "shared" {
  name     = "shared-app-rg"
  location = "South India"
}

output "rg_name" {
  value = azurerm_resource_group.shared.name
}
