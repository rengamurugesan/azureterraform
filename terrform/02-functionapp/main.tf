# data "azurerm_storage_account" "sa" {
#   name                = var.storage_account_name
#   resource_group_name = var.resource_group_name

# }
resource "azurerm_linux_function_app" "this" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.primary_access_key

  dynamic "site_config" {
    for_each = var.site_config
    content {
      always_on     = lookup(site_config.value, "always_on", false)
      ftps_state    = lookup(site_config.value, "ftps_state", null)
      http2_enabled = lookup(site_config.value, "http2_enabled", null)
      # min_tls_version           = lookup(site_config.value, "min_tls_version", null)
      #  scm_type = lookup(site_config.value, "scm_type", null)
      #  use_32_bit_worker_process = lookup(site_config.value, "use_32_bit_worker_process", null)
      websockets_enabled = lookup(site_config.value, "websockets_enabled", null)
      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", []) != [] ? [lookup(site_config.value, "application_stack", {})] : []
        content {
          dotnet_version = lookup(application_stack.value, "dotnet_version", null)
          # Add other application stack attributes as needed
        }
      }



      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? [lookup(site_config.value, "cors", {})] : []
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = lookup(cors.value, "support_credentials", false)
        }
      }
      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restrictions", null) != null ? lookup(site_config.value, "ip_restrictions", []) : []
        content {
          ip_address = ip_restriction.value.ip_address
          action     = lookup(ip_restriction.value, "action", "Allow")
          priority   = lookup(ip_restriction.value, "priority", 100)
          name       = lookup(ip_restriction.value, "name", null)
          # Add other ip_restriction attributes as needed
        }
      }



    }

  }

  app_settings = var.app_settings

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "auth_settings" {
    for_each = var.auth_settings != null ? [var.auth_settings] : []
    content {
      enabled                        = lookup(auth_settings.value, "enabled", false)
      issuer                         = lookup(auth_settings.value, "issuer", null)
      token_store_enabled            = lookup(auth_settings.value, "token_store_enabled", null)
      unauthenticated_client_action  = lookup(auth_settings.value, "unauthenticated_client_action", null)
      default_provider               = lookup(auth_settings.value, "default_provider", null)
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", null)
      # Add other auth_settings attributes as needed
    }
  }
  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  dynamic "auth_settings_v2" {
    for_each = var.auth_settings_v2 != null ? [var.auth_settings_v2] : []
    content {
      auth_enabled           = lookup(auth_settings_v2.value, "auth_enabled", false)
      runtime_version        = lookup(auth_settings_v2.value, "runtime_version", null)
      config_file_path       = lookup(auth_settings_v2.value, "config_file_path", null)
      require_authentication = lookup(auth_settings_v2.value, "require_authentication", null)
      unauthenticated_action = lookup(auth_settings_v2.value, "unauthenticated_action", null)
      # Add other auth_settings_v2 attributes as needed

      dynamic "login" {
        for_each = lookup(auth_settings_v2.value, "login", []) != [] ? [lookup(auth_settings_v2.value, "login", {})] : []
        content {
          token_store_enabled = lookup(login.value, "token_store_enabled", null)
          # Add other login attributes as needed
        }
      }





    }

  }
  # backup {
  #   dynamic "schedule" {
  #     for_each = var.backup != null && contains(keys(var.backup), "schedule") ? [var.backup.schedule] : []
  #     content {
  #       frequency_interval       = lookup(schedule.value, "frequency_interval", 1)
  #       frequency_unit           = lookup(schedule.value, "frequency_unit", "Day")
  #       keep_at_least_one_backup = lookup(schedule.value, "keep_at_least_one_backup", true)
  #       retention_period_days    = lookup(schedule.value, "retention_period_days", 30)
  #       start_time               = lookup(schedule.value, "start_time", null)
  #     }
  #   }
  #   name                = lookup(var.backup, "name", null)
  #   storage_account_url = lookup(var.backup, "storage_account_url", null)
  #   enabled             = lookup(var.backup, "enabled", true)
  # }

  # dynamic "virtual_network_subnet_id" {
  #   for_each = var.virtual_network_subnet_id != null ? [var.virtual_network_subnet_id] : []
  #   content {
  #     id = virtual_network_subnet_id.value
  #   }
  # }



  tags = var.tags

}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.function_app_name}-diagnostics"
  target_resource_id         = azurerm_linux_function_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "FunctionAppLogs"
  }

  # enabled_log {
  #   category = "AppServiceConsoleLogs"
  # }

  # enabled_log {
  #   category = "AppServiceAppLogs"
  # }

  metric {
    category = "AllMetrics"
  }
}

# resource "azurerm_private_endpoint" "function_app" {
#   name                = "${var.function_app_name}-pe"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = var.private_endpoint_subnet_id

#   private_service_connection {
#     name                           = "${var.function_app_name}-psc"
#     private_connection_resource_id = azurerm_linux_function_app.this.id
#     subresource_names              = ["sites"]
#     is_manual_connection           = false
#   }

#   tags = var.tags
# }

# resource "azurerm_private_dns_a_record" "function_app" {
#   name                = azurerm_linux_function_app.this.name
#   zone_name           = var.private_dns_zone_name
#   resource_group_name = var.private_dns_zone_rg
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.function_app.private_service_connection[0].private_ip_address]
# }

