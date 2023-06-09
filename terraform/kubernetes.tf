resource "azurerm_kubernetes_cluster" "cluster_aks" {
  name                = var.aks_cluster.name
  resource_group_name = azurerm_resource_group.cloudproject.name
  location            = var.region_general
  dns_prefix          = var.aks_cluster.dns_prefix

  azure_policy_enabled             = var.aks_cluster.azure_policy_enabled
  http_application_routing_enabled = var.aks_cluster.http_app_routing_enabled
  private_cluster_enabled          = var.aks_cluster.private_cluster_enabled

  default_node_pool {
    name       = var.aks_cluster.default_node_pool_name
    node_count = var.aks_cluster.default_node_pool_node_count
    vm_size    = var.aks_cluster.default_node_pool_vm_size
    vnet_subnet_id = azurerm_subnet.subred_kubernetes.id
  }

  identity {
    type = var.aks_cluster.identity_type
  }

  network_profile {
    network_plugin = "azure"
  }

  ingress_application_gateway {
    gateway_id = azurerm_application_gateway.load_balancer.id 
  }

  role_based_access_control_enabled = true

  tags = var.tags_general
  depends_on = [azurerm_application_gateway.load_balancer]
}

data "azurerm_user_assigned_identity" "cluster_aks_agentpool" {
  name                = "${azurerm_kubernetes_cluster.cluster_aks.name}-agentpool"
  resource_group_name = azurerm_resource_group.cloudproject.name
  depends_on          = [azurerm_kubernetes_cluster.cluster_aks]
}

resource "azurerm_role_assignment" "cluster_aks_acr" {
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.container_registry.id
  principal_id         = data.azurerm_user_assigned_identity.cluster_aks_agentpool.principal_id
}
