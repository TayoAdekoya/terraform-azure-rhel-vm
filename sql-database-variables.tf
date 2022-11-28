variable "sql_rg_name" {
  description = "The resource group the sql server should be placed in"
}

variable "server_name" {
  description = "Name of the server. "
}

variable "admin_login_name" {
  description = "Login name for the sql server administrator. If not set the default login name will be 'kitten83'."
  default     = "Tee83"
}

variable "storage_name" {
  description = "Name of Storage account"
  default     = "sqlstorage" 
}

variable "storage_tier" {
  description = "storage account tier"
  default     = "Standard"
}

variable "storage_type" {
  description = "account replication type"
  default     = "LRS"
}
