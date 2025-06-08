variable "prefix_vnet" {
  description = "Virtual network prefix"
  type        = string
  default     = "vnet"
}
variable "prefix_rg" {
  type    = string
  default = "rg"
}
variable "spoke_vnet_name" {
  type = string

}
variable "hub_vnet_subscription" {
  type = string
}
variable "hub_vnet_name" {
  type = string
}
variable "hub_rg" {
  type = string
}

variable "spoke_rg" {
  type = string

}
variable "spoke_vnet_addr_prefix" {
  type = string
}


variable "tags" {
  type = map(string)
  default = {
    "workload" = "spoke"
  }
}
variable "prefix_nsg" {
  type    = string
  default = "nsg"
}

variable "shared-subnet-name" {
  type = string
}
variable "shared-subnet-addr" {
  type = string
}
variable "nsg_shared_name" {
  type = string
}
variable "environment" {
  description = "Deployment environment (dev, qa, pre-prod, prod)"
  type        = string
  default     = "hub"
}

variable "region" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "workload" {
  description = "Workload or application name"
  type        = string
  default     = "conn"
}

variable "instance" {
  description = "Instance number"
  type        = string
  default     = "001"
}
