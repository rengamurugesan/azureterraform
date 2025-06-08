# variable "public_ip_name" {
#   description = "The name of the public IP address."
#   type        = string
# }

variable "service_name" {
  description = "Name of the service consuming the public IP"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the public IP."
  type        = string
}

variable "location" {
  description = "The Azure location where the public IP will be created."
  type        = string
}

variable "allocation_method" {
  description = "Defines the allocation method for the public IP address. Possible values are Static or Dynamic."
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  type        = string
  default     = "Standard"
}



variable "zones" {
  description = "A list of availability zones in which the Public IP Address should be created."
  type        = list(string)
  default     = null
}
variable "ip_version" {
  description = "The IP version to use for the public IP address. Possible values are IPv4 or IPv6."
  type        = string
  default     = "IPv4"
}

variable "idle_timeout_in_minutes" {
  description = "The idle timeout in minutes for the public IP address."
  type        = number
  default     = null
}

# variable "dns_settings" {
#   description = "DNS settings for the public IP (object with domain_name_label and optional reverse_fqdn)"
#   type = object({
#     domain_name_label = string
#     reverse_fqdn      = optional(string)
#   })
#   default = null
# }

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
