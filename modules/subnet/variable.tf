
variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes for the subnet."
  type        = list(string)
}

variable "delegations" {
  description = "A list of subnet delegations."
  type = list(object({
    name = string
    service_delegations = list(object({
      name    = string
      actions = list(string)
    }))
  }))
  default = []
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = null
}

variable "enforce_private_link_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet."
  type        = bool
  default     = null
}

variable "enforce_private_link_service_network_policies" {
  description = "Enable or Disable network policies for the private link service on the subnet."
  type        = bool
  default     = null
}



variable "private_link_service_network_policies_enabled" {
  description = "Whether network policies are enabled for private link services on the subnet."
  type        = bool
  default     = null
}

variable "nat_gateway_id" {
  description = "The ID of the NAT Gateway to associate with the subnet."
  type        = string
  default     = null
}

variable "route_table_id" {
  description = "The ID of the Route Table to associate with the subnet."
  type        = string
  default     = null
}

variable "service_endpoint_policy_ids" {
  description = "The list of IDs of Service Endpoint Policies to associate with the subnet."
  type        = list(string)
  default     = null
}

variable "timeouts" {
  description = "Timeouts configuration block."
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}


variable "default_outbound_access_enabled" {
  description = "Whether the subnet should have default outbound access enabled."
  type        = bool
  default     = null
}

variable "private_endpoint_network_policies" {
  description = "Configuration block for private endpoint network policies."
  type        = any
  default     = "Disabled"
}
