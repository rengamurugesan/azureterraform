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
    use_azuread_auth = true

  }
}



provider "azurerm" {
  features {}
  alias           = "connectivity"
  subscription_id = local.connectivity_subscription

}

