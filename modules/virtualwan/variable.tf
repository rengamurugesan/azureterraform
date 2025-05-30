variable "virtual_wan_name" {
  description = "The name of the Virtual WAN."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location where the Virtual WAN will be created."
  type        = string
}

variable "virtual_wan_type" {
  description = "The type of the Virtual WAN. Possible values are 'Basic' or 'Standard'."
  type        = string
  default     = null
}
variable "disable_vpn_encryption" {
  description = "Should VPN encryption be disabled?"
  type        = bool
  default     = false
}

variable "office365_local_breakout_category" {
  description = "The Office365 local breakout category."
  type        = string
  default     = null
}

variable "allow_branch_to_branch_traffic" {
  description = "Allow branch-to-branch traffic?"
  type        = bool
  default     = true
}

variable "timeouts" {
  description = "Timeouts configuration for the resource group"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = {}
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "admin"
  }
}
