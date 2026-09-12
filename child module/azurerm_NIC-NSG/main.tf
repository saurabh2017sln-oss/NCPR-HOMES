# variable "nic-nsg" {}
# resource "azurerm_network_interface_security_group_association" "nsg-nic" {
#   network_interface_id      = data.azurerm_network_interface.nic.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

# data "azurerm_network_interface" "nic" {
#   name                = var.nic-nsg.nic_name
#   resource_group_name = var.nic-nsg.resource_group_name
# }

# data "azurerm_network_security_group" "nsg" {
#   name                = var.nic-nsg.nsg_name
#   resource_group_name = var.nic-nsg.resource_group_name
# }
