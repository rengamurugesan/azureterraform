resource "azurerm_virtual_wan" "this" {
  name                              = var.virtual_wan_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  type                              = var.virtual_wan_type
  disable_vpn_encryption            = var.disable_vpn_encryption
  office365_local_breakout_category = var.office365_local_breakout_category
  allow_branch_to_branch_traffic    = var.allow_branch_to_branch_traffic
  tags                              = var.tags

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = lookup(var.timeouts, "create", null)
    update = lookup(var.timeouts, "update", null)
    delete = lookup(var.timeouts, "delete", null)
  }
}

