resource "azurerm_storage_account" "tf_state_storage" {
  name                            = "${local.name_prefix}${local.region_short}${local.environment}sa"
  resource_group_name             = data.azurerm_resource_group.resource_group.name
  location                        = data.azurerm_resource_group.resource_group.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  network_rules {
    default_action = "Deny"
    ip_rules       = [var.public_ip]
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_storage_container" "tfstate_storage_container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tf_state_storage.id
  container_access_type = "private"
}

resource "azurerm_storage_account" "generic_storage" {
  name                            = "${local.name_prefix}${local.region_short}${local.environment}sageneric"
  resource_group_name             = data.azurerm_resource_group.resource_group.name
  location                        = data.azurerm_resource_group.resource_group.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_storage_container" "generic_storage_container" {
  name                  = "generic"
  storage_account_id    = azurerm_storage_account.generic_storage.id
  container_access_type = "private"
}
