resource "azurerm_public_ip" "public_ips" {
  name                = "pip-${var.service_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = var.allocation_method
  sku               = var.sku

  # Optional properties  
  zones = var.zones != null ? var.zones : []

  # Optional: IP version (IPv4 or IPv6)
  ip_version = var.ip_version

  # Optional: DNS settings
  #   dynamic "dns_settings" {
  #     for_each = var.dns_settings != null ? [var.dns_settings] : []
  #     content {
  #       domain_name_label = dns_settings.value.domain_name_label
  #       reverse_fqdn      = lookup(dns_settings.value, "reverse_fqdn", null)
  #     }
  #   }

  # Optional: Idle timeout
  idle_timeout_in_minutes = var.idle_timeout_in_minutes

  # Optional: Tags
  tags = var.tags
}

# Example variables for all possible configurations
