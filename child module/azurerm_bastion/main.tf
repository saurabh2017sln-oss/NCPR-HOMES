variable "bastion" {}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion.bastion_name
  location            = var.bastion.location
  resource_group_name = var.bastion.resource_group_name

  ip_configuration {
    name                 = var.bastion.config_name
    subnet_id            = data.azurerm_subnet.subnet.id
    public_ip_address_id = data.azurerm_public_ip.public-ip.id
  }
}

data "azurerm_subnet" "subnet" {
  name                 = var.bastion.subnet_name
  virtual_network_name = var.bastion.vnet_name
  resource_group_name  = var.bastion.resource_group_name
}

data "azurerm_public_ip" "public-ip" {
  name                = var.bastion.public_ip_name
  resource_group_name = var.bastion.resource_group_name
}