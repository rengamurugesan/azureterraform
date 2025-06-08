

resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name

  dynamic "soa_record" {
    for_each = var.soa_record_enabled ? [1] : []
    content {
      email         = var.soa_record_email
      serial_number = var.soa_record_serial_number
      refresh_time  = var.soa_record_refresh_time
      retry_time    = var.soa_record_retry_time
      expire_time   = var.soa_record_expire_time
      minimum_ttl   = var.soa_record_minimum_ttl
      ttl           = var.soa_record_ttl
    }
  }
  tags = var.tags

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}





