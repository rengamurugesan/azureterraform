data "azurerm_client_config" "current" {}

# Get info about the existing Hub VNET
data "azurerm_virtual_network" "hub_vnet" {

  provider = azurerm.hub-subscription

  name                = local.hub_vnet_name
  resource_group_name = local.hub_rg
}

# Get info about the existing Hub RG
data "azurerm_resource_group" "hub_rg" {

  provider = azurerm.hub-subscription
  name     = local.hub_rg

}
locals {
  base_name          = "${var.workload}-${var.environment}-${var.region}-${var.instance}"
  hub_rg             = var.hub_rg == "" ? "${var.prefix_rg}-${local.base_name}" : var.hub_rg
  hub_vnet_name      = var.hub_vnet_name == "" ? "${var.prefix_vnet}-${local.base_name}" : var.hub_vnet_name
  spoke_rg           = var.spoke_rg == "" ? "${var.prefix_rg}-${local.base_name}" : var.spoke_rg
  spoke_vnet_name    = var.spoke_vnet_name == "" ? "${var.prefix_vnet}-${local.base_name}" : var.spoke_vnet_name
  hub_subscriptionId = var.hub_vnet_subscription == "" ? data.azurerm_client_config.current.subscription_id : var.hub_vnet_subscription
  nsg_shared_name    = var.nsg_shared_name == "" ? "${var.prefix_nsg}-${local.base_name}" : var.nsg_shared_name

}

