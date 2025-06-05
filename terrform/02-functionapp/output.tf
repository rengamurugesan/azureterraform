output "function_app_id" {
  description = "The ID of the Function App."
  value       = azurerm_linux_function_app.this.id
}

output "function_app_default_hostname" {
  description = "The default hostname of the Function App."
  value       = azurerm_linux_function_app.this.default_hostname
}
