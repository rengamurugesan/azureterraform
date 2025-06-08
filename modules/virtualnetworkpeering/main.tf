

resource "azurerm_virtual_network_peering" "this" {
  name                                   = var.peering_name
  resource_group_name                    = var.resource_group_name
  virtual_network_name                   = var.virtual_network_name
  remote_virtual_network_id              = var.remote_virtual_network_id
  allow_virtual_network_access           = var.allow_virtual_network_access != null ? var.allow_virtual_network_access : true
  peer_complete_virtual_networks_enabled = var.peer_complete_virtual_networks_enabled != null ? var.peer_complete_virtual_networks_enabled : true

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [1] : []
    content {
      create = lookup(var.timeouts, "create", null)
      update = lookup(var.timeouts, "update", null)
      delete = lookup(var.timeouts, "delete", null)
    }
  }
}






