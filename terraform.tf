terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.66.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "lucas-jones-sandbox-rg"
    storage_account_name = "ljuksdevsa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

