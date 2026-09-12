rgs = {
  rg1 = {
    name = "saurabh-rg"
  location = "westus" }

  rg2 = {
    name = "baba-rg"
  location = "westus" }

  rg3 = {
    name = "baba-rg"
  location = "westus" }

}

# storages = {
#   storage1 = {
#     name                     = "saurabhstorage"
#     resource_group_name      = "saurabh-rg"
#     location                 = "westus"
#     account_tier             = "Standard"
#     account_replication_type = "GRS"
#   }
# }

# stg-container = {
#   stg1 = {
#     name                  = "baba-container"
#     container_access_type = "private"
#     storage_name          = "saurabhstorage"
#     rg_name               = "saurabh-rg"

#   }
# }

vnets = {
  vnet1 = {
    name                = "global-vnet"
    location            = "westus"
    resource_group_name = "saurabh-rg"
    address_space       = ["10.0.0.0/16"]
  }
}

snets = {
  subnet1 = {
    name                 = "fontend-subnet"
    resource_group_name  = "saurabh-rg"
    virtual_network_name = "global-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }

  # subnet2 = {
  #   name                 = "backend-subnet"
  #   resource_group_name  = "saurabh-rg"
  #   virtual_network_name = "global-vnet"
  #   address_prefixes     = ["10.0.2.0/24"]
  # }

  subnet3 = {
    name                 = "azurebastionsubnet"
    resource_group_name  = "saurabh-rg"
    virtual_network_name = "global-vnet"
    address_prefixes     = ["10.0.3.0/24"]
  }

  subnet4 = {
    name                 = "appgw-subnet"
    resource_group_name  = "saurabh-rg"
    virtual_network_name = "global-vnet"
    address_prefixes     = ["10.0.4.0/24"]
  }
}

pips = {
  public-ip1 = {
    name                = "nat-publicip"
    resource_group_name = "saurabh-rg"
    location            = "westus"
    allocation_method   = "Static"
  }

  public-ip2 = {
    name                = "bastion-publicip"
    resource_group_name = "saurabh-rg"
    location            = "westus"
    allocation_method   = "Static"
  }
  public-ip3 = {
    name                = "appgateway-publicip"
    resource_group_name = "saurabh-rg"
    location            = "westus"
    allocation_method   = "Static"
  }
}

nat-pip = {
  nat      = "nat-gateway"
  rg_name  = "saurabh-rg"
  pip_name = "bastion-publicip"
}

nats = {
  name                    = "nat-gateway"
  location                = "westus"
  rg_name                 = "saurabh-rg"
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

nsgs = {
  nsg1 = {
    nsg_name                   = "frontend-ssh-nsg"
    location                   = "westus"
    resource_group_name        = "saurabh-rg"
    security_rule_name         = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  nsg2 = {
    nsg_name                   = "frontend-http-nsg"
    location                   = "westus"
    resource_group_name        = "saurabh-rg"
    security_rule_name         = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  nsg3 = {
    nsg_name                   = "backend-ssh-nsg"
    location                   = "westus"
    resource_group_name        = "saurabh-rg"
    security_rule_name         = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  nsg4 = {
    nsg_name                   = "backned-http-nsg"
    location                   = "westus"
    resource_group_name        = "saurabh-rg"
    security_rule_name         = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}




nics = {
  nic1 = {
    nic_name                      = "frontend-nic"
    location                      = "westus"
    rg_name                       = "saurabh-rg"
    ipconfig-name                 = "frontend-ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_name                   = "frontend-subnet"
    vnet_name                     = "global-vnet"
    pip_name                      = "appgateway-publicip"
  }
  nic2 = {
    nic_name                      = "backned-nic"
    location                      = "westus"
    rg_name                       = "saurabh-rg"
    ipconfig-name                 = "backend-ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_name                   = "frontend-subnet"
    vnet_name                     = "global-vnet"
    pip_name                      = "appgateway-publicip"
  }
}

bastion = {
  bastion_name        = "backend_bastion"
  location            = "westus"
  resource_group_name = "saurabh-rg"
  config_name         = "backend-ipconfig"
  subnet_name         = "bastion-publicip"
  vnet_name           = "global-vnet"
  public_ip_name      = "bastion-publicip"
}


vms = {
  vm1 = {
    vm_name                         = "frontend_vm"
    location                        = "westus"
    resource_group_name             = "saurabh-rg"
    vm_size                         = "Standard_DS2_v3"
    storage_publisher               = "Canonical"
    offer                           = "ubuntu-24_04-lts"
    sku                             = "server"
    version                         = "latest"
    storage_disk_name               = "frontend_ubuntuos_disk"
    caching                         = "ReadWrite"
    create_option                   = "FromImage"
    managed_disk_type               = "Standard_LRS"
    disk_size_gb                    = 30
    computer_name                   = "Saurabh-frontend"
    admin_username                  = "saurabh2301"
    admin_password                  = "sangee@230103"
    disable_password_authentication = "false"
    nic_name                        = "frontend-nic"
  }

  vm2 = {
    vm_name                         = "backend_vm"
    location                        = "westus"
    resource_group_name             = "saurabh-rg"
    vm_size                         = "Standard_DS2_v3"
    storage_publisher               = "Canonical"
    offer                           = "ubuntu-24_04-lts"
    sku                             = "server"
    version                         = "latest"
    storage_disk_name               = "backend_ubuntuos_disk"
    caching                         = "ReadWrite"
    create_option                   = "FromImage"
    managed_disk_type               = "Standard_LRS"
    disk_size_gb                    = 30
    computer_name                   = "Saurabh-frontend"
    admin_username                  = "saurabh2301"
    admin_password                  = "sangee@230103"
    disable_password_authentication = false
    nic_name                        = "backned-nic"
  }
}

appgateway = {
  appgateway1 = {
    appgateway_name         = "application_gateway"
    resource_group_name     = "saurabh-rg"
    location                = "westus"
    sku_name                = "Standard_v2"
    tier                    = "Standard_v2"
    capacity                = 2
    gateway_ip_config_name  = "gateway_ip_configuration"
    subnet_name             = "appgw-subnet"
    vnet_name               = "global-vnet"
    frontend_port_name      = "http_port"
    frontend_port           = 80
    frontend_ip_config_name = "appgateway-frontend-ip"
    public_ip_name          = "appgateway-publicip"

    backend_address_pools = [
      {
        name     = "netflix-backend-pool"
        nic_name = "frontend-nic"
      },
      {
        name     = "starbucks-backend-pool"
        nic_name = "backned-nic"
      }
    ]

    backend_http_settings = [
      {
        name                  = "backend_setting"
        cookie_based_affinity = "Disabled"
        path                  = "/"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
      }
    ]

    http_listeners = [
      {
        name      = "netflix-listener"
        protocol  = "Http"
        host_name = "netflix.b18g158.online"
      },
      {
        name      = "starbucks-listener"
        protocol  = "Http"
        host_name = "starbucks.b18g158.online"
      }
    ]

    request_routing_rules = [
      {
        name                       = "netflix-routing-rule"
        priority                   = 100
        rule_type                  = "Basic"
        http_listener_name         = "netflix-listener"
        backend_address_pool_name  = "netflix-backend-pool"
        backend_http_settings_name = "backend_setting"
      },
      {
        name                       = "starbucks-routing-rule"
        priority                   = 110
        rule_type                  = "Basic"
        http_listener_name         = "starbucks-listener"
        backend_address_pool_name  = "starbucks-backend-pool"
        backend_http_settings_name = "backend_setting"
      }
    ]
  }
}



