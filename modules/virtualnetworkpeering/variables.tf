variable "peering_name" {
  description = "Name of the peering"
  type        = string
}



variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}
variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network"

}
variable "remote_virtual_network_id" {
  type        = string
  description = "Remote virtual network id"

}
variable "allow_virtual_network_access" {
  type        = bool
  default     = true
  description = "Allow all address space in that network"

}
variable "peer_complete_virtual_networks_enabled" {
  type        = bool
  default     = true
  description = "value"

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




