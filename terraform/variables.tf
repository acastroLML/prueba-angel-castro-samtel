variable "region_general" {
  description = "region general"
  type        = string
}

variable "tags_general" {
  description = "Tags generales"
  type        = map(any)
}

# ResourceGroups
variable "rg_general" {
  description = "Nombre del resource group del projecto"
  type        = string
}

# Terraform State Backend
variable "estado_storage" {
  description = "Estado Terraform: variables storage"
  type        = map(any)
}

variable "estado_container" {
  description = "Estado Terraform: variables container"
  type        = map(any)
}

# Redes
variable "vnet_general" {
  description = "Red: parametros"
  type        = map(any)
}

variable "subnet_appgateway" {
  description = "Subnet para application gateway"
  type        = map(any)
}

variable "subnet_componentes" {
  description = "Subnet para componentes"
  type        = map(any)
}

variable "subnet_componentes_endpoints" {
  description = "Endpoints admitidos para la subnet"
  type        = list(string)
}

variable "subnet_kubernetes" {
  description = "Subnet para kubernetes"
  type        = map(any)
}

variable "acr_dns_zone" {
  description = "Zona DNS para el ACR"
  type        = string
}

variable "acr_dns_zone_vnet_link" {
  description = "Zona DNS para el ACR: parametros del link con vnet"
  type        = string
}


# Container Registry
variable "container_registry" {
  description = "Parametros del Container Registry"
  type        = map(any)
}

variable "container_registry_endpoint" {
  description = "Parametros del Endpoint del Container Registry"
  type        = map(any)
}

# LoadBalancer
variable "load_balancer_ip" {
  description = "IP para el load balancer"
  type        = map(any)
}

variable "load_balancer" {
  description = "Load balancer: parametros del application gateway"
  type        = map(any)
}

# Kubernetes
variable "aks_cluster" {
 description = "AKS parameters"
 type        = map(any)
}

# VM to AzureDevOps
variable "vm_project_ip" {
  description = "VM para Azure DevOps Pool"
  type        = map(any)
}

variable "vm_project_nic" {
  description = "Interfaz de red para la VM"
  type        = map(any)
}

variable "vm_project_vm" {
  description = "VM to Azure DevOps"
  type        = map(any)
}
