resource "azurerm_private_endpoint" "generic_storage_pe" {
  name                = "${local.name_prefix}-${local.region_short}-${local.environment}-generic-storage-pe"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  subnet_id           = azurerm_subnet.storage_snet.id

  private_service_connection {
    name                           = "${local.name_prefix}-${local.region_short}-${local.environment}-generic-storage-psc"
    private_connection_resource_id = azurerm_storage_account.generic_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_private_dns_a_record" "generic_storage_blob_record" {
  name                = azurerm_storage_account.generic_storage.name
  zone_name           = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.generic_storage_pe.private_service_connection[0].private_ip_address]

  lifecycle {
    ignore_changes = [tags]
  }
}
