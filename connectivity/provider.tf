terraform {
  required_version = ">= 1.9.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.4.0"
    }

  }

  backend "azurerm" {
    # use_azuread_auth = true
    use_oidc = true

  }


}



provider "azurerm" {
  features {}

  subscription_id = local.connectivity_subscription

}
provider "random" {
  # No specific configuration needed for random provider
}
