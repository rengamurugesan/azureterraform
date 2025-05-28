resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  # Optional settings
  dns_servers             = try(var.dns_servers, null)
  bgp_community           = try(var.bgp_community, null)
  edge_zone               = try(var.edge_zone, null)
  flow_timeout_in_minutes = try(var.flow_timeout_in_minutes, null)

  # DDoS Protection
  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_id != null ? [1] : []
    content {
      id     = var.ddos_protection_plan_id
      enable = var.ddos_protection_plan_enable
    }
  }


  #   # Subnets (example)
  #   dynamic "subnet" {
  #     for_each = var.subnets
  #     content {
  #       name              = subnet.value.name
  #       address_prefix    = subnet.value.address_prefix
  #       security_group    = subnet.value.security_group
  #       route_table       = subnet.value.route_table
  #       service_endpoints = subnet.value.service_endpoints
  #       delegation {
  #         name = subnet.value.delegation_name
  #         service_delegation {
  #           name    = subnet.value.service_delegation_name
  #           actions = subnet.value.service_delegation_actions
  #         }
  #       }
  #       private_endpoint_network_policies_enabled     = subnet.value.private_endpoint_network_policies_enabled
  #       private_link_service_network_policies_enabled = subnet.value.private_link_service_network_policies_enabled
  #     }
  #   }

  tags = var.tags
}

