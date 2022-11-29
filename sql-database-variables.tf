variable "mysql_rg_name" {
  description = "The resource group the sql server should be placed in"
}

variable "storage_name" {
  description = "Name of Storage account"
  default     = "mysqlstorage" 
}

variable "storage_tier" {
  description = "storage account tier"
  default     = "Standard"
}

variable "storage_type" {
  description = "account replication type"
  default     = "LRS"
}

variable "server_name" {
  description = "Name of the server."
  default     = "mysqlserver"
}

variable "admin_login_name" {
  description = "Login name for the sql server administrator. If not set the default login name will be 'kitten83'."
  default     = "Tee83"
}

variable "firewall_name" {
  description = "MySQL firewall name."
  default     = "firewallrule"
}

variable "firewall_start_ip" {
  description = "MySQL firewall rule start ip address."
  default     = "0.0.0.0"
}

variable "firewall_end_ip" {
  description = "MySQL firewall rule end ip address."
  default     = "0.0.0.0"
}
