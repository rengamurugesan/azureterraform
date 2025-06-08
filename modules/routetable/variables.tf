variable "route_table_name" {
  description = "The name of the route table."
  type        = string
}

variable "location" {
  description = "The Azure location where the route table will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "routes" {
  description = "A list of route objects."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
    has_bgp_override       = optional(bool)
  }))
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
