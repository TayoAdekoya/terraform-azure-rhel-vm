# create resource group
resource "azurerm_resource_group" "mysql_rg" {
  name     = var.mysql_rg_name
  location = var.location

   tags = {
    environment = var.environment
  }
}

# crete random string
resource "random_string" "password" {
  length           = 32
  special          = true
  override_special = "!@#$%&"
}

# create storage account
resource "azurerm_storage_account" "mysql_storage" {
  name                     = "${var.storage_name}${var.environment}"
  resource_group_name      = "${var.mysql_rg_name}"
  location                 = "${var.location}"
  account_tier             = "${var.storage_tier}"
  account_replication_type = "${var.storage_type}"

   tags = {
    environment = var.environment
  }
}

# create SQL server
resource "azurerm_mysql_server" "mysql_server" {
  name                         = "${var.server_name}${var.environment}-mysql"
  resource_group_name          = "${var.mysql_rg_name}"
  location                     = "${var.location}"
  administrator_login          = "${var.admin_login_name}"
  administrator_login_password = "${random_string.password.result}"
  version    = "5.7"
  sku_name   = "GP_Gen5_2"
  storage_mb = 5120


  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
  tags = {
    environment = var.environment
  }
}

# create mysql firewall rule
resource "azurerm_mssql_firewall_rule" "mysql_firewall" {
  name                = "${var.firewall_name}${var.environment}-mysql"
  server_id           = azurerm_mysql_server.mysql_server.id
  start_ip_address    = "${var.firewall_start_ip}"
  end_ip_address      = "${var.firewall_end_ip}"
}

# create MySQL database
resource "azurerm_mssql_database" "test" {
  name                = "acctest-db-d"
  server_id           = azurerm_mysql_server.mysql_server.id
  collation           = "SQL_LATIN1_GENERAL_CP1_CI_AS"

   tags = {
    environment = var.environment
  }
}