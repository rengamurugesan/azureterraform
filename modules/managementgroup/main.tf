resource "azurerm_management_group" "mg" {
  display_name = var.display_name
  name         = var.name
  parent_id    = var.parent_id

  tags = var.tags

  timeouts {
    create = lookup(var.timeouts, "create", null)
    update = lookup(var.timeouts, "update", null)
    delete = lookup(var.timeouts, "delete", null)
  }
}
