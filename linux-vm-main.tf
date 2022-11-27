provider "azurerm" {
  features {}
}

# creates resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.name_prefix}-rg"
  location = "${var.location}"
}

# Generate a random vm name
resource "random_string" "linux-vm-name" {
  length  = 8
  upper   = false
  number  = false
  lower   = true
  special = false
}

# Create Security Group to access linux
resource "azurerm_network_security_group" "linux-vm-nsg" {
  name                = "linux-${lower(var.environment)}-${random_string.linux-vm-name.result}-nsg"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "AllowHTTP"
    description                = "Allow HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  tags = {
    environment = var.environment
  }
}

# Associate the linux NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "linux-vm-nsg-association" {
  depends_on=[azurerm_resource_group.network-rg]

  subnet_id                 = azurerm_subnet.network-subnet.id
  network_security_group_id = azurerm_network_security_group.linux-vm-nsg.id
}

# Get a Static Public IP
resource "azurerm_public_ip" "linux-vm-ip" {
  depends_on=[azurerm_resource_group.network-rg]

  name                = "linux-${random_string.linux-vm-name.result}-ip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Static"
  
  tags = { 
    environment = var.environment
  }
}

# Create Network Card for linux VM
resource "azurerm_network_interface" "linux-vm-nic" {
  depends_on=[azurerm_resource_group.network-rg]

  name                = "linux-${random_string.linux-vm-name.result}-nic"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}
