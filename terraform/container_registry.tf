resource "azurerm_container_registry" "container_registry" {
  name                = var.container_registry.name
  resource_group_name = azurerm_resource_group.cloudproject.name
  location            = var.region_general
  sku                 = var.container_registry.sku
  admin_enabled       = var.container_registry.admin_enabled

  public_network_access_enabled  = var.container_registry.public_network_access_enabled
  network_rule_bypass_option     = var.container_registry.network_rule_bypass_option

  network_rule_set {
    default_action  = var.container_registry.network_rule_set_default_action
    virtual_network {
      action    = var.container_registry.network_rule_set_virtual_network
      subnet_id = azurerm_subnet.subred_componentes.id
    }
  }

  tags = var.tags_general
}

resource "azurerm_private_endpoint" "container_registry" {
  name                = var.container_registry_endpoint.name
  resource_group_name = azurerm_resource_group.cloudproject.name
  location            = var.region_general
  subnet_id           = azurerm_subnet.subred_componentes.id

  private_service_connection {
    name                           = var.container_registry_endpoint.private_service_connection_name
    private_connection_resource_id = azurerm_container_registry.container_registry.id
    is_manual_connection           = var.container_registry_endpoint.private_service_connection_is_manual_connection
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.acr_dns_zone.name
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_dns_zone.id]
  }

  tags = var.tags_general
}
