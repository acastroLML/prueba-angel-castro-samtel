resource "azurerm_virtual_network" "red" {
  name                = var.vnet_general.name
  location            = var.region_general
  resource_group_name = azurerm_resource_group.cloudproject.name
  address_space       = [var.vnet_general.address_space]

  tags = var.tags_general
}

resource "azurerm_subnet" "subred_appgateway" {
  name                                           = var.subnet_appgateway.name
  resource_group_name                            = azurerm_resource_group.cloudproject.name
  virtual_network_name                           = azurerm_virtual_network.red.name
  address_prefixes                               = [var.subnet_appgateway.address_prefixes]
  enforce_private_link_endpoint_network_policies = var.subnet_appgateway.private_link
}

resource "azurerm_subnet" "subred_componentes" {
  name                                           = var.subnet_componentes.name
  resource_group_name                            = azurerm_resource_group.cloudproject.name
  virtual_network_name                           = azurerm_virtual_network.red.name
  address_prefixes                               = [var.subnet_componentes.address_prefixes]
  enforce_private_link_endpoint_network_policies = var.subnet_componentes.private_link

  service_endpoints = var.subnet_componentes_endpoints
}
 
resource "azurerm_subnet" "subred_kubernetes" {
  name                                           = var.subnet_kubernetes.name
  resource_group_name                            = azurerm_resource_group.cloudproject.name
  virtual_network_name                           = azurerm_virtual_network.red.name
  address_prefixes                               = [var.subnet_kubernetes.address_prefixes]
  enforce_private_link_endpoint_network_policies = var.subnet_kubernetes.private_link
}

resource "azurerm_private_dns_zone" "acr_dns_zone" {
  name                = var.acr_dns_zone
  resource_group_name = azurerm_resource_group.cloudproject.name

  tags = var.tags_general
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_dns_zone_link" {
  name                  = var.acr_dns_zone_vnet_link
  resource_group_name   = azurerm_resource_group.cloudproject.name
  private_dns_zone_name = azurerm_private_dns_zone.acr_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.red.id

  tags = var.tags_general
}
