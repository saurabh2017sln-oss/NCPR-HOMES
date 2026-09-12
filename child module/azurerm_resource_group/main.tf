variable "rgs" {}

resource "azurerm_resource_group" "resouce-gr" {
    for_each = var.rgs
    name = each.value.name
    location = each.value.location
}