
output "public_ip_address" {
  description = "The public IP address of the resource."
  value       = azurerm_public_ip.public_ips.ip_address
}

# output "public_ip_id" {
#   description = "The ID of the public IP resource."
#   value       = azurerm_public_ip.this.id
# }

# output "public_ips" {
#   # value = { for ip in azurerm_public_ip.public_ips : ip.service_name => ip.public_ip }
#   value = azurerm_public_ip.public_ips[*].id
# }
output "public_ip_ids" {
  description = "The IDs of the public IP resources."
  value       = azurerm_public_ip.public_ips[*].id
}
output "public_ip_fqdn" {
  description = "The FQDN of the public IP resource."
  value       = azurerm_public_ip.public_ips.fqdn
}
