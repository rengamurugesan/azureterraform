output "virtual_wan_id" {
  description = "The ID of the Virtual WAN."
  value       = azurerm_virtual_wan.this.id
}

output "virtual_wan_name" {
  description = "The name of the Virtual WAN."
  value       = azurerm_virtual_wan.this.name
}

output "virtual_wan_location" {
  description = "The location of the Virtual WAN."
  value       = azurerm_virtual_wan.this.location
}

output "virtual_wan_resource_group_name" {
  description = "The resource group name of the Virtual WAN."
  value       = azurerm_virtual_wan.this.resource_group_name
}
