variable "nats" {}

resource "azurerm_nat_gateway" "nat" {
  name                    = var.nats.name
  location                = var.nats.location
  resource_group_name     = var.nats.rg_name
  sku_name                = var.nats.sku_name
  idle_timeout_in_minutes = var.nats.idle_timeout_in_minutes
}
    
