resource "azurerm_resource_group" "rg" {
  provider = azurerm.connectivity
  for_each = var.regions
  name     = "rg-${each.key}"
  location = each.key
}
