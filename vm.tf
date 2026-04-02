resource "azurerm_network_interface" "vm_nic" {
  name                = "${local.name_prefix}-${local.region_short}-${local.environment}-vm-nic"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  ip_configuration {
    name                          = "${local.name_prefix}-${local.region_short}-${local.environment}-vm-ipconfig"
    subnet_id                     = azurerm_subnet.compute_snet.id
    private_ip_address_allocation = "Dynamic"
  }

}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${local.name_prefix}-${local.region_short}-${local.environment}-vm"
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  location              = data.azurerm_resource_group.resource_group.location
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = "Standard_A2_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${local.name_prefix}-${local.region_short}-${local.environment}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${local.name_prefix}-${local.region_short}-${local.environment}-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
