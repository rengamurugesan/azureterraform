
variable "function_app_name" {
  description = "The name of the Linux Function App."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "primary_access_key" {
  description = "The primary access key for the storage account."
  type        = string
}

variable "site_config" {
  description = "Site configuration for the Function App."
  type        = any
}

variable "app_settings" {
  description = "Application settings for the Function App."
  type        = map(string)
}

variable "identity" {
  description = "Managed identity configuration."
  type        = any
  default     = null
}

variable "auth_settings" {
  description = "Authentication settings."
  type        = any
  default     = null
}

variable "connection_strings" {
  description = "List of connection strings."
  type        = list(any)
  default     = []
}

variable "auth_settings_v2" {
  description = "Authentication settings v2."
  type        = any
  default     = null
}

variable "backup" {
  description = "Backup configuration."
  type        = any
  default     = null
}

variable "cors" {
  description = "CORS configuration."
  type        = any
  default     = null
}

variable "inbound_ip_rules" {
  description = "List of inbound IP rules."
  type        = list(any)
  default     = null
}

variable "outbound_ip_rules" {
  description = "List of outbound IP rules."
  type        = list(any)
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "The subnet ID for virtual network integration."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace."
  type        = string
}
