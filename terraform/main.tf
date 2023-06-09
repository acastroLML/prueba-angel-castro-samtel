terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "dev-rg-cloudproject"
    storage_account_name = "devestadostorage"
    container_name       = "devestadocontainer"
    key                  = "estado/terraform.state"
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  subscription_id = "6631b735-74c5-4139-8cf6-85608a1cac25"
  features {}
}

# ResourceGroup
resource "azurerm_resource_group" "cloudproject" {
  name     = var.rg_general
  location = var.region_general

  tags = var.tags_general
}

# Terraform State Backend
resource "azurerm_storage_account" "estado" {
  name                     = var.estado_storage.name
  resource_group_name      = azurerm_resource_group.cloudproject.name
  location                 = var.region_general
  account_tier             = var.estado_storage.account_tier
  account_replication_type = var.estado_storage.account_replication_type

  tags = var.tags_general
}

resource "azurerm_storage_container" "estado" {
  name                  = var.estado_container.name
  storage_account_name  = azurerm_storage_account.estado.name
  container_access_type = var.estado_container.container_access_type
}
