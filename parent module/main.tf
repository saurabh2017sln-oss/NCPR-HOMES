module "resource_group" {
  source = "../child module/azurerm_resource_group"
  rgs    = var.rgs
}

# module "storage_account" {
#   source = "../child module/azurerm_storage"
#   storages = var.storages
#   depends_on = [ module.resource_group ]
# }

# module "storage_blob_container" {
#   source = "../child module/azurerm_blob_container"
#   stg-container = var.stg-container
#   depends_on = [ module.storage_account ]
# }

module "virtual_network" {
  source     = "../child module/azurerm_virtual_network"
  vnets      = var.vnets
  depends_on = [module.resource_group]
}

module "subnet" {
  source     = "../child module/azurerm_subnet"
  snets      = var.snets
  depends_on = [module.virtual_network]
}

module "public-ip" {
  source     = "../child module/azurerm_PIP"
  depends_on = [module.resource_group]
  pips       = var.pips
}

module "network_security_group" {
  source     = "../child module/azurerm_NSG"
  nsgs       = var.nsgs
  depends_on = [module.resource_group]
}

module "network_interface_card" {
  source     = "../child module/azurerm_NIC"
  nics       = var.nics
  depends_on = [module.resource_group]
}

module "bastion" {
  source     = "../child module/azurerm_bastion"
  bastion    = var.bastion
  depends_on = [module.resource_group, module.public-ip, module.subnet]
}

module "virtual_machine" {
  source     = "../child module/azurerm_VM"
  vms        = var.vms
  depends_on = [module.subnet]
}

module "nat" {
  source     = "../child module/azurerm_nat_gateway"
  depends_on = [module.subnet]
  nats       = var.nats
}
module "application_gateway" {
  source     = "../child module/azurerm_application_gateway"
  appgateway = var.appgateway
  depends_on = [module.resource_group, module.subnet, module.public-ip, module.network_interface_card, module.virtual_machine]
}



