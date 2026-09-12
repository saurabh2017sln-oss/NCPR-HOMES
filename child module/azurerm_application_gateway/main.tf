variable "appgateway" {}

resource "azurerm_application_gateway" "network" {
  for_each            = var.appgateway
  name                = each.value.appgateway_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = each.value.sku_name
    tier     = each.value.tier
    capacity = each.value.capacity
  }

  gateway_ip_configuration {
    name      = each.value.gateway_ip_config_name
    subnet_id = data.azurerm_subnet.subnet[each.key].id
  }

  frontend_port {
    name = each.value.frontend_port_name
    port = each.value.frontend_port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_config_name
    public_ip_address_id = data.azurerm_public_ip.public-ip[each.key].id
  }

  dynamic "backend_address_pool" {
    for_each = each.value.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      ip_addresses = lookup(backend_address_pool.value, "nic_name", null) != null ? [data.azurerm_network_interface.nics[backend_address_pool.value.nic_name].private_ip_address] : lookup(backend_address_pool.value, "ip_addresses", null)
    }
  }

  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_settings
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      path                  = backend_http_settings.value.path
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
    }
  }

  dynamic "http_listener" {
    for_each = each.value.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = each.value.frontend_ip_config_name
      frontend_port_name             = each.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = lookup(http_listener.value, "host_name", null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.request_routing_rules
    content {
      name                       = request_routing_rule.value.name
      priority                   = request_routing_rule.value.priority
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
  }
}

data "azurerm_subnet" "subnet" {
  for_each             = var.appgateway
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "public-ip" {
  for_each            = var.appgateway
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_network_interface" "nics" {
  for_each            = local.nic_map
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

locals {
  nic_list = flatten([
    for app_key, app in var.appgateway : [
      for pool in app.backend_address_pools : {
        nic_name            = pool.nic_name
        resource_group_name = app.resource_group_name
      } if lookup(pool, "nic_name", null) != null
    ]
  ])
  nic_map = {
    for item in local.nic_list : item.nic_name => item
  }
}


