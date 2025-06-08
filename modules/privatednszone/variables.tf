variable "name" {
  description = "The name of the Private DNS Zone."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Private DNS Zone."
  type        = string
}

variable "soa_record_enabled" {
  description = "Whether to enable the SOA record block."
  type        = bool
  default     = false
}

variable "soa_record_host" {
  description = "The domain name of the authoritative name server for the SOA record."
  type        = string
  default     = null
}

variable "soa_record_email" {
  description = "The email of the administrator for the SOA record."
  type        = string
  default     = null
}

variable "soa_record_serial_number" {
  description = "The serial number for the SOA record."
  type        = number
  default     = null
}

variable "soa_record_refresh_time" {
  description = "The refresh time for the SOA record."
  type        = number
  default     = null
}

variable "soa_record_retry_time" {
  description = "The retry time for the SOA record."
  type        = number
  default     = null
}

variable "soa_record_expire_time" {
  description = "The expire time for the SOA record."
  type        = number
  default     = null
}

variable "soa_record_minimum_ttl" {
  description = "The minimum TTL for the SOA record."
  type        = number
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "create_timeout" {
  description = "The timeout for creating the Private DNS Zone."
  type        = string
  default     = "30m"
}

variable "update_timeout" {
  description = "The timeout for updating the Private DNS Zone."
  type        = string
  default     = "30m"
}

variable "delete_timeout" {
  description = "The timeout for deleting the Private DNS Zone."
  type        = string
  default     = "30m"
}
variable "soa_record_ttl" {
  description = "The TTL (Time To Live) for the SOA record."
  type        = number
  default     = 3600
}
