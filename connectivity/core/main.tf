
resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = var.tags
  # Removed unsupported attribute allow_blob_public_access
  # Removed unsupported attribute enable_https_traffic_only
  is_hns_enabled = var.is_hns_enabled

  large_file_share_enabled = var.large_file_share_enabled
  # Removed unsupported attribute minimum_tls_version
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public

  dynamic "network_rules" {
    for_each = var.network_rules
    content {
      default_action             = lookup(network_rules.value, "default_action", null)
      bypass                     = lookup(network_rules.value, "bypass", null)
      ip_rules                   = lookup(network_rules.value, "ip_rules", null)
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids", null)
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties
    content {
      delete_retention_policy {
        days = lookup(blob_properties.value.delete_retention_policy, "days", null)
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties
    content {
      logging {
        delete                = lookup(queue_properties.value.logging, "delete", null)
        read                  = lookup(queue_properties.value.logging, "read", null)
        write                 = lookup(queue_properties.value.logging, "write", null)
        version               = lookup(queue_properties.value.logging, "version", "1.0")
        retention_policy_days = lookup(queue_properties.value.logging, "retention_policy_days", null)
      }

      hour_metrics {
        enabled               = lookup(queue_properties.value.hour_metrics, "enabled", null)
        include_apis          = lookup(queue_properties.value.hour_metrics, "include_apis", null)
        retention_policy_days = lookup(queue_properties.value.hour_metrics, "retention_policy_days", null)
        version               = lookup(queue_properties.value.hour_metrics, "version", "1.0")
      }

      minute_metrics {
        enabled               = lookup(queue_properties.value.minute_metrics, "enabled", null)
        include_apis          = lookup(queue_properties.value.minute_metrics, "include_apis", null)
        retention_policy_days = lookup(queue_properties.value.minute_metrics, "retention_policy_days", null)
        version               = lookup(queue_properties.value.minute_metrics, "version", "1.0")
      }
    }
  }


  timeouts {
    create = lookup(var.timeouts, "create", null)
    update = lookup(var.timeouts, "update", null)
    delete = lookup(var.timeouts, "delete", null)
  }
  lifecycle {
    # prevent_destroy = true
    ignore_changes = [
      tags,
      network_rules,
      blob_properties,
      queue_properties
    ]
  }
}


resource "azurerm_private_endpoint" "this" {
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-pe-connection"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  tags = var.tags
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  count              = var.customer_managed_key_enabled ? 1 : 0
  storage_account_id = azurerm_storage_account.this.id
  key_vault_id       = var.key_vault_id
  key_name           = var.key_name
  key_version        = var.key_version
}
resource "azurerm_storage_management_policy" "this" {
  storage_account_id = azurerm_storage_account.this.id

  rule {
    name    = "default"
    enabled = true

    filters {
      blob_types   = ["blockBlob"]
      prefix_match = ["*"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 30
        tier_to_archive_after_days_since_modification_greater_than = 90
        delete_after_days_since_modification_greater_than          = 365
      }
      snapshot {
        change_tier_to_archive_after_days_since_creation = 90
        change_tier_to_cool_after_days_since_creation    = 23
        delete_after_days_since_creation_greater_than    = 31
      }
      version {
        change_tier_to_archive_after_days_since_creation = 9
        change_tier_to_cool_after_days_since_creation    = 90
        delete_after_days_since_creation                 = 3
      }
    }
  }
}
resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "diag-${var.name}"
  target_resource_id         = azurerm_storage_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # enabled_log {
  #   category = "AuditEvent"
  # }

  metric {
    category = "AllMetrics"
  }
}

# resource "azurerm_private_dns_a_record" "this" {
#   name                = azurerm_storage_account.this.name
#   zone_name           = "privatelink.blob.core.windows.net"
#   resource_group_name = var.private_dns_zone_resource_group
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.this.private_service_connection[0].private_ip_address]
# }

