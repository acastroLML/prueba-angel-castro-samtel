locals {
  backend_address_pool_name      = "${azurerm_virtual_network.red.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.red.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.red.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.red.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.red.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.red.name}-rqrt"
}

resource "azurerm_public_ip" "load_balancer" {
 name                = var.load_balancer_ip.name
 resource_group_name = azurerm_resource_group.cloudproject.name
 location            = var.region_general
 allocation_method   = var.load_balancer_ip.allocation_method
 sku                 = var.load_balancer_ip.sku

  tags = var.tags_general
}

resource "azurerm_application_gateway" "load_balancer" {
  name                = var.load_balancer.name
  resource_group_name = azurerm_resource_group.cloudproject.name
  location            = var.region_general

  sku {
    name     = var.load_balancer.sku_name
    tier     = var.load_balancer.sku_tier
    capacity = var.load_balancer.sku_capacity
  }

  gateway_ip_configuration {
    name      = "dev-agw-project-ip"
    subnet_id = azurerm_subnet.subred_appgateway.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.load_balancer.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
  }

  tags = var.tags_general
  depends_on = [azurerm_public_ip.load_balancer]
}
