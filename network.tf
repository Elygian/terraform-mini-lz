resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_prefix}-${local.region_short}-${local.environment}-vnet"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  address_space       = ["10.0.0.0/16"]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_subnet" "default_snet" {
  name                 = "${local.name_prefix}-${local.region_short}-${local.environment}-snet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "storage_snet" {
  name                 = "${local.name_prefix}-${local.region_short}-${local.environment}-storage-snet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "compute_snet" {
  name                 = "${local.name_prefix}-${local.region_short}-${local.environment}-compute-snet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "${local.region_long}.privatelink.blob.core.windows.net"
  resource_group_name = data.azurerm_resource_group.resource_group.name

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "name" {
  name                  = "${local.name_prefix}-${local.region_short}-${local.environment}-dns-link"
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  lifecycle {
    ignore_changes = [tags]
  }
}
