# The Shared Subnet
resource "azurerm_subnet" "snetsharedsubnet" {
  name                 = var.shared-subnet-name
  resource_group_name  = azurerm_resource_group.spoke_rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = [var.shared-subnet-addr]
}

# NSG for Shared Subnet
resource "azurerm_network_security_group" "snetshared_nsg" {
  name                = local.nsg_shared_name
  location            = var.region
  resource_group_name = azurerm_resource_group.spoke_rg.name
  security_rule {}

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "shared_nsg_assoc" {
  subnet_id                 = azurerm_subnet.snetsharedsubnet.id
  network_security_group_id = azurerm_network_security_group.snetshared_nsg.id
}
