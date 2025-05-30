variable "name" {
  description = "The name of the virtual network."
  type        = string
}

variable "location" {
  description = "The Azure location where the virtual network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "List of DNS servers to use for the virtual network."
  type        = list(string)
  default     = null
}

variable "bgp_community" {
  description = "The BGP community attribute."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Virtual Network should exist."
  type        = string
  default     = null
}

variable "flow_timeout_in_minutes" {
  description = "The flow timeout in minutes for the virtual network."
  type        = number
  default     = null
}

variable "ddos_protection_plan_id" {
  description = "The ID of the DDoS protection plan."
  type        = string
  default     = null
}

variable "ddos_protection_plan_enable" {
  description = "Whether DDoS protection is enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
