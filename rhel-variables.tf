######################
## RHEL - Variables ##
######################

variable "linux_vm_image_offer" {
  type        = string
  description = "Virtual machine source image offer"
  default     = "RHEL"
}

variable "linux_vm_image_publisher" {
  type        = string
  description = "Virtual machine source image publisher"
  default     = "RedHat"
}

variable "rhel_8_3_sku" {
  type        = string
  description = "SKU for RHEL 8.3"
  default     = "8_3"
}

variable "rhel_8_3_gen2_sku" {
  type        = string
  description = "SKU for RHEL 8.3 Gen2"
  default     = "83-gen2"
}

variable "rhel_8_4_sku" {
  type        = string
  description = "SKU for RHEL 8.4"
  default     = "8_4"
}

variable "rhel_8_4_gen2_sku" {
  type        = string
  description = "SKU for RHEL 8.4 Gen2"
  default     = "84-gen2"
}

variable "rhel_8_5_sku" {
  type        = string
  description = "SKU for RHEL 8.5"
  default     = "8_5"
}

variable "rhel_8_5_gen2_sku" {
  type        = string
  description = "SKU for RHEL 8.5 Gen2"
  default     = "85-gen2"
}