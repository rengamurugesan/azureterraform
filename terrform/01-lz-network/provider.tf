# Azure provider version 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.1.0"
    }

  }

  backend "azurerm" {

    key = "lz-network"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azurerm" {
  alias           = "hub-subscription"
  subscription_id = local.hub_subscriptionId
  features {
  }
}

provider "azuread" {

}
