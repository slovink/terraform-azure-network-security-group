# Azure Provider configuration
provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "git::git@github.com:slovink/terraform-azure-resource-group.git?ref=1.0.0"
  label_order = ["name", "environment", ]
  name        = "app-name"
  environment = "test"
  location    = "Canada Central"
}

module "vnet" {
  #depends_on  = [module.resource_group]
  source      = "git@github.com:slovink/terraform-azure-vnet.git?ref=1.0.0"
  label_order = ["name", "environment"]


  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.30.0.0/22"
  enable_ddos_pp      = false
  client_id           = "xxxxxxxxxxx"
  client_secret       = "xxxxxxxxxxxx"
  subscription_id     = "xxxxxxxx"
  tenant_id           = "xxxxxxxxx"

}

module "subnet" {
  source = "git::git@github.com:slovink/terraform-azure-subnet.git?ref=1.0.0"

  name                 = "example-subnet"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet.vnet_name)

  # Subnet Configuration
  subnet_prefixes               = ["10.30.0.0/24"]
  disable_bgp_route_propagation = false

  # routes
  enable_route_table = true

  routes = [
    {
      name                   = "rt-app-test"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.20.0.4"
    }
  ]

}

module "network_security_group" {
  depends_on              = [module.subnet]
  resource_group_location = module.resource_group.resource_group_location
  source                  = "../"
  label_order             = ["name", "environment"]
  app_name                = "app"
  environment             = "test"
  subnet_ids              = module.subnet.default_subnet_id
  resource_group_name     = module.resource_group.resource_group_name
  inbound_rules = [
    {
      name                       = "ssh"
      priority                   = 101
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "67.23.123.234/32"
      source_port_range          = "*"
      destination_address_prefix = "0.0.0.0/0"
      destination_port_range     = "22"
      description                = "ssh allowed port"
    },
    {
      name                       = "https"
      priority                   = 102
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "0.0.0.0/0"
      destination_port_range     = "22"
      description                = "ssh allowed port"
    }
  ]
}
