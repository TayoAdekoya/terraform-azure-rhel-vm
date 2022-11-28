
provider "azurerm" {
  features {}
}

# Generate random password
resource "random_password" "linux-vm-password" {
  length           = 16
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}

# creates resource group
resource "azurerm_resource_group" "vm-rg" {
  name     = var.rg_name
  location = var.location
}

# Create Security Group to access linux
resource "azurerm_network_security_group" "linux-vm-nsg" {
  name                = "linux-${(var.environment)}-nsg"
  location            = var.location
  resource_group_name = var.rg_name

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
  subnet_id                 = azurerm_subnet.network-subnet.id
  network_security_group_id = azurerm_network_security_group.linux-vm-nsg.id
}

# Get a Static Public IP
resource "azurerm_public_ip" "linux-vm-ip" {
  name                = "linux-${var.environment}-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  
  tags = { 
    environment = var.environment
  }
}

# Create Network Card for linux VM
resource "azurerm_network_interface" "linux-vm-nic" {
  name                = "linux-${var.environment}-nic"
  location            = var.location
  resource_group_name = var.rg_name
  
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

# Create Linux VM with linux server
resource "azurerm_linux_virtual_machine" "linux-vm1" {
  count                 = 2
  name                  = "VM1-${var.list}"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.linux-vm-nic.id]
  size                  = var.linux_vm1_size

  source_image_reference {
    offer     = var.linux_vm_image_offer
    publisher = var.linux_vm_image_publisher
    sku       = var.rhel_8_3_sku
    version   = "latest"
  }

  os_disk {
    name                 = "linux-${var.environment}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "linux-${var.environment}-vm"
  admin_username = var.linux_admin_username
  admin_password = random_password.linux-vm-password.result

  disable_password_authentication = false

  tags = {
    environment = var.environment
  }
}

# Create Linux VM with linux server
resource "azurerm_linux_virtual_machine" "linux-vm2" {
  count                 = 2
  name                  = "VM2-${var.list}"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.linux-vm-nic.id]
  size                  = var.linux_vm2_size

  source_image_reference {
    offer     = var.linux_vm_image_offer
    publisher = var.linux_vm_image_publisher
    sku       = var.rhel_8_4_sku
    version   = "latest"
  }

  os_disk {
    name                 = "linux-${var.environment}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "linux-${var.environment}-vm"
  admin_username = var.linux_admin_username
  admin_password = random_password.linux-vm-password.result

  disable_password_authentication = false

  tags = {
    environment = var.environment
  }
}

# Create Linux VM with linux server
resource "azurerm_linux_virtual_machine" "linux-vm3" {
  count                 = 2
  name                  = "VM3-${var.list}"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.linux-vm-nic.id]
  size                  = var.linux_vm3_size

  source_image_reference {
    offer     = var.linux_vm_image_offer
    publisher = var.linux_vm_image_publisher
    sku       = var.rhel_8_5_sku
    version   = "latest"
  }

  os_disk {
    name                 = "linux-${var.environment}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "linux-${var.environment}-vm"
  admin_username = var.linux_admin_username
  admin_password = random_password.linux-vm-password.result

  disable_password_authentication = false

  tags = {
    environment = var.environment
  }
}
