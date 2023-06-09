resource "azurerm_public_ip" "vm_project_ip" {
  name                = var.vm_project_ip.name
  resource_group_name = azurerm_resource_group.cloudproject.name
  location            = var.region_general
  allocation_method   = var.vm_project_ip.allocation_method
  sku                 = var.vm_project_ip.sku

  tags = var.tags_general
}

resource "azurerm_network_interface" "vm_project" {
  name                = var.vm_project_nic.name
  resource_group_name = azurerm_resource_group.cloudproject.name
  location            = var.region_general

  ip_configuration {
    name                          = var.vm_project_nic.ip_config_name
    subnet_id                     = azurerm_subnet.subred_appgateway.id
    private_ip_address_allocation = var.vm_project_nic.ip_config_private_allocation
    public_ip_address_id          = azurerm_public_ip.vm_project_ip.id
  }

  tags = var.tags_general
}

resource "azurerm_virtual_machine" "vm_project" {
  name                  = var.vm_project_vm.name
  resource_group_name   = azurerm_resource_group.cloudproject.name
  location              = var.region_general
  network_interface_ids = [azurerm_network_interface.vm_project.id]
  vm_size               = var.vm_project_vm.vm_size

  delete_os_disk_on_termination    = var.vm_project_vm.delete_os_disk_on_termination
  delete_data_disks_on_termination = var.vm_project_vm.delete_data_disks_on_termination

  storage_image_reference {
    publisher = var.vm_project_vm.storage_image_publisher
    offer     = var.vm_project_vm.storage_image_offer
    sku       = var.vm_project_vm.storage_image_sku
    version   = var.vm_project_vm.storage_image_version
  }

  storage_os_disk {
    name              = var.vm_project_vm.storage_os_name
    caching           = var.vm_project_vm.storage_os_caching
    create_option     = var.vm_project_vm.storage_os_create_option
    managed_disk_type = var.vm_project_vm.storage_os_managed_disk_type
  }

  identity {
    type = "SystemAssigned"
  }

  os_profile {
    computer_name  = "devdevopsagent"
    admin_username = "angelcastro"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("../id_rsa.pub")
      path     = "/home/angelcastro/.ssh/authorized_keys"
    }
  }

  tags = var.tags_general
}
