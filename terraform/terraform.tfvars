region_general   = "East US 2"

tags_general = {
  "dev"     = "Angel Castro"
  "project" = "Azure Cloud"
}

# ResourceGroup
rg_general = "dev-rg-cloudproject"

# Terraform State Backend
estado_storage = {
  name                     = "devestadostorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

estado_container = {
  name                  = "devestadocontainer"
  container_access_type = "private"
}

# Redes
vnet_general = {
  name          = "dev-vnet-cloudproject"
  address_space = "192.168.40.0/21"
}

subnet_appgateway = {
  name             = "dev--subnet-appgateway"
  address_prefixes = "192.168.44.0/25"
  private_link     = true
}

subnet_componentes = {
  name             = "dev--subnet-componentes"
  address_prefixes = "192.168.44.128/25"
  private_link     = true
}

subnet_componentes_endpoints = [
  "Microsoft.ContainerRegistry"
]

subnet_kubernetes = {
  name             = "dev--subnet-aks"
  address_prefixes = "192.168.40.0/22"
  private_link     = true
}

acr_dns_zone = "privatelink.azurecr.io"
acr_dns_zone_vnet_link = "dev-dnsz-acr-link"

# Container Registry
container_registry = {
  name                             = "devacrcloudproject"
  sku                              = "Premium"
  admin_enabled                    = false
  public_network_access_enabled    = false
  network_rule_bypass_option       = "AzureServices"
  network_rule_set_default_action  = "Allow"
  network_rule_set_virtual_network = "Allow"
}

container_registry_endpoint = {
  name                                            = "dev-acr-endpoint"
  private_service_connection_name                 = "dev-endpoint-acr"
  private_service_connection_is_manual_connection = false
}

# LoadBalancer
load_balancer_ip = {
  name              = "dev-load-balancer-ip"
  allocation_method = "Static"
  sku               = "Standard"
}

load_balancer = {
  name         = "dev-load-balancer-project"
  sku_name     = "WAF_v2"
  sku_tier     = "WAF_v2"
  sku_capacity = 2
}

# Kubernetes
aks_cluster = {
  name                         = "dev-aks-project"
  dns_prefix                   = "akscommonprj"
  azure_policy_enabled         = true
  http_app_routing_enabled     = false
  private_cluster_enabled      = true
  default_node_pool_name       = "aksnp1"
  default_node_pool_node_count = 3
  default_node_pool_vm_size    = "Standard_DS2_v2"
  identity_type                = "SystemAssigned"
}

# VM to AzureDevOps
vm_project_ip = {
  name              = "dev-devops-ip"
  allocation_method = "Static"
  sku               = "Standard"
}

vm_project_nic = {
  name                         = "dev-devops-nic"
  ip_config_name               = "vm_devops_ip"
  ip_config_private_allocation = "Dynamic"
}

vm_project_vm = {
  name                             = "dev-devops-vm"
  vm_size                          = "Standard_DS11_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  storage_image_publisher          = "Canonical"
  storage_image_offer              = "UbuntuServer"
  storage_image_sku                = "20.04-LTS"
  storage_image_version            = "latest"
  storage_os_name                  = "devdevopsvm"
  storage_os_caching               = "ReadWrite"
  storage_os_create_option         = "FromImage"
  storage_os_managed_disk_type     = "Standard_LRS"  
}
