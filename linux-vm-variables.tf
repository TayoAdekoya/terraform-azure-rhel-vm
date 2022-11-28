variable "linux_vm1_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
}

variable "linux_vm2_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
}

variable "linux_vm3_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
}

variable "company" {
  type        = string
  description = "Name of Company"
}

variable "app_name" {
  type        = string
  description = "name of App"
}

variable "environment" {
  type        = string
  description = "Tag name for environment"
}

variable "location" {
  type        = string
  description = "Location of resources"
}

variable "rg_name" {
  type        = string
  description = "Name of Resource Group"
}

variable "list" {
  type        = string
  description = "list for VM counts"  
    default   = "a-b"
}

variable "linux_admin_username" {
  type        = string
  description = "Username for Virtual Machine administrator account"
  default     = ""
}

variable "linux_admin_password" {
  type        = string
  description = "Password for Virtual Machine administrator account"
  default     = ""
}