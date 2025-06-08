output "subnet_id" {
  description = "The ID of the subnet."
  value       = azurerm_subnet.this[*].id
  #value = { for subnet in azurerm_subnet.this : subnet.name => subnet.id }
}

output "subnet_name" {
  description = "The name of the subnet."
  value       = azurerm_subnet.this.name
}

output "subnet_address_prefixes" {
  description = "The address prefixes of the subnet."
  value       = azurerm_subnet.this.address_prefixes
}
