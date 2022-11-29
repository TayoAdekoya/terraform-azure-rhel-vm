output "mysql_server_name" {
  description = "Name of the server created. Use this if more databases needs to be added to the server. "
  value = "${azurerm_mysql_server.mysql_server.name}"
}

output "admin_password" {
  description = "Password for admin on the sql server."
  value = "${random_string.password.result}"
  sensitive = true
}

output "mysql_server_id" {
  description = "Id of Azure MYSQL Server created."
  value = "${azurerm_mysql_server.mysql_server.id}"
}
