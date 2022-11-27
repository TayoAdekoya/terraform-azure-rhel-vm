####################
# Common Variables #
####################
company     = "kopicloud"
app_name    = "iac-test"
environment = "dev"
location    = "northeurope"

###########
# Network #
###########
network-vnet-cidr   = "10.128.0.0/16"
network-subnet-cidr = "10.128.1.0/24"

##################
# VM Information #
##################
linux_vm1_size        = "Standard_E16ds_v5"
linux_vm2_size        = "Standard_E8ds_v5"
linux_vm3_size        = "Standard_FX12mds"
linux_admin_username = "tfadmin"
