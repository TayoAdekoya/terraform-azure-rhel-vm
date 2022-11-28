# create resource group
resource "azurerm_resource_group" "sql_rg" {
  name     = var.sql_rg_name
  location = var.location
}

# create SQL server
resource "azurerm_sql_server" "sql_server" {
  name                         = "${var.server_name}-${var.environment}-sql"
  resource_group_name          = "${var.sql_rg_name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "${var.admin_login_name}"
  administrator_login_password = "${random_string.password.result}"

  tags = {
    environment = var.environment
  }
}

# create storage account
resource "azurerm_storage_account" "sql_storage" {
  name                     = "${var.storage_name}-${var.environent}"
  resource_group_name      = "${var.sql_rg_name}"
  location                 = "${var.location}"
  account_tier             = "${var.storage_tier}"
  account_replication_type = "${var.storage_type}"
}
