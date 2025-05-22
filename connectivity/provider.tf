terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.1"
    }
  }

  backend "azurerm" {
    container_name       = "test"
    key                  = "terraform.tfstate"
    storage_account_name = "denycheckst"
    resource_group_name  = "denycheckrg"

  }
}


provider "azurerm" {
  alias = "connectivity"
  features {}
  subscription_id = local.connectivity_subscription
}

provider "azurerm" {
  alias = "management"
  features {}
  subscription_id = local.management_subscription
}
# backend "azurerm" {
#     resource_group_name  = "your-resource-group-name"
#     storage_account_name = "your-storage-account-name"
#     container_name       = "your-container-name"
#     key                  = "terraform.tfstate"  # Optional, can be any name
#     access_key = "your-storage-account-access-key" # Or leave empty for Service Principal
#   }
