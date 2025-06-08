resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value.name

      dynamic "service_delegation" {
        for_each = delegation.value.service_delegations
        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
  service_endpoints                             = try(var.service_endpoints, null)
  default_outbound_access_enabled               = try(var.default_outbound_access_enabled, true)
  private_endpoint_network_policies             = try(var.private_endpoint_network_policies, "disabled")
  private_link_service_network_policies_enabled = try(var.private_link_service_network_policies_enabled, true)
  service_endpoint_policy_ids                   = try(var.service_endpoint_policy_ids, null)


  #   dynamic "service_endpoints" {
  #     for_each = var.service_endpoints != null ? [1] : []
  #     content {
  #       service_endpoints = var.service_endpoints
  #     }
  #   }




  #   dynamic "private_endpoint_network_policies_enabled" {
  #     for_each = var.private_endpoint_network_policies_enabled != null ? [1] : []
  #     content {
  #       private_endpoint_network_policies_enabled = var.private_endpoint_network_policies_enabled
  #     }
  #   }

  #   dynamic "private_link_service_network_policies_enabled" {
  #     for_each = var.private_link_service_network_policies_enabled != null ? [1] : []
  #     content {
  #       private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  #     }
  #   }

  #   dynamic "nat_gateway_id" {
  #     for_each = var.nat_gateway_id != null ? [1] : []
  #     content {
  #       nat_gateway_id = var.nat_gateway_id
  #     }
  #   }

  #   dynamic "route_table_id" {
  #     for_each = var.route_table_id != null ? [1] : []
  #     content {
  #       route_table_id = var.route_table_id
  #     }
  #   }

  #   dynamic "service_endpoint_policy_ids" {
  #     for_each = var.service_endpoint_policy_ids != null ? [1] : []
  #     content {
  #       service_endpoint_policy_ids = var.service_endpoint_policy_ids
  #     }
  #   }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [1] : []
    content {
      create = lookup(var.timeouts, "create", null)
      update = lookup(var.timeouts, "update", null)
      delete = lookup(var.timeouts, "delete", null)
    }
  }
}

