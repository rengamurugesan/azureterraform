# Spoke Resource group
resource "azurerm_resource_group" "spoke_rg" {
  name     = local.spoke_rg
  location = var.region

  tags = var.tags
}


# Spoke VNET 
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = local.spoke_vnet_name
  location            = var.region
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = [var.spoke_vnet_addr_prefix]

  tags = var.tags
}
