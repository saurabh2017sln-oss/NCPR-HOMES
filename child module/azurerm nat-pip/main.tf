variable "nat-pip" {}

resource "azurerm_nat_gateway_public_ip_association" "nat-pip" {
  nat_gateway_id       = data.azurerm_nat_gateway.nat.id
  public_ip_address_id = data.azurerm_public_ip.pip.id
}

data "azurerm_nat_gateway" "nat" {
  name                = var.nat-pip.nat
  resource_group_name = var.nat-pip.rg_name
}

data "azurerm_public_ip" "pip" {
  name                = var.nat-pip.pip_name
  resource_group_name = var.nat-pip.rg_name
}
