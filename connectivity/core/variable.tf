variable "name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location for the resources."
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account."
  type        = string
}

variable "account_replication_type" {
  description = "The type of replication to use for this storage account."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled?"
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "Is Large File Share enabled?"
  type        = bool
  default     = false
}

variable "allow_nested_items_to_be_public" {
  description = "Allow nested items to be public."
  type        = bool
  default     = false
}

variable "network_rules" {
  description = "Network rules for the storage account."
  type        = any
  default     = []
}

variable "blob_properties" {
  description = "Blob properties for the storage account."
  type        = any
  default     = []
}

variable "queue_properties" {
  description = "Queue properties for the storage account."
  type        = any
  default     = []
}

variable "timeouts" {
  description = "Timeouts for create, update, and delete operations."
  type        = map(string)
  default     = {}
}

variable "private_endpoint_subnet_id" {
  description = "The subnet ID for the private endpoint."
  type        = string
}

variable "customer_managed_key_enabled" {
  description = "Enable customer managed key for the storage account."
  type        = bool
  default     = false
}

variable "key_vault_id" {
  description = "The ID of the Key Vault containing the key."
  type        = string
  default     = null
}

variable "key_name" {
  description = "The name of the Key Vault key."
  type        = string
  default     = null
}

variable "key_version" {
  description = "The version of the Key Vault key."
  type        = string
  default     = null
}

variable "enable_diagnostics" {
  description = "Enable diagnostics storage account."
  type        = bool
  default     = false
}

variable "diagnostic_storage_account_id" {
  description = "The ID of the storage account for diagnostics."
  type        = string
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  type        = string
  default     = null
}

variable "diagnostic_logs" {
  description = "List of diagnostic logs settings."
  type        = list(any)
  default     = []
}

variable "diagnostic_metrics" {
  description = "List of diagnostic metrics settings."
  type        = list(any)
  default     = []
}
