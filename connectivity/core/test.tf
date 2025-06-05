locals {
  connectivity_base_name = "${var.workload}-${var.environment}-${var.region}-${var.instance}"

}


module "storage_account" {
  source                   = "../../modules/storageaccount"
  name                     = "azdostorageaccount0001"
  location                 = module.resource_group.resource_group_location
  resource_group_name      = module.resource_group.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
    owner       = "admin"
  }
  private_endpoint_subnet_id = module.subnet["gneralsubnet"].subnet_id[0]
  log_analytics_workspace_id = module.loganalyticsworkspace.log_analytics_workspace_id



  depends_on = [module.resource_group, module.loganalyticsworkspace, module.subnet]
}
