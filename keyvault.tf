resource "azurerm_key_vault" "akv" {
  name                = "${var.akv_config.name}-${var.environment}-${var.locationshort}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.current.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = merge({ Name = "${var.akv_config.name}-${var.environment}-${var.locationshort}" })
  sku_name            = var.akv_config.sku_name

  enabled_for_disk_encryption     = lookup(var.akv_config.akv_features, "enabled_for_disk_encryption", null)
  enabled_for_deployment          = lookup(var.akv_config.akv_features, "enabled_for_deployment", null)
  enabled_for_template_deployment = lookup(var.akv_config.akv_features, "enabled_for_template_deployment", null)
  # soft_delete_enabled             = lookup(var.akv_config.akv_features, "soft_delete_enabled", null)
  purge_protection_enabled = lookup(var.akv_config.akv_features, "purge_protection_enabled", null)

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = var.project_ips_public
  }
}

resource "azurerm_private_endpoint" "pvtendpoint_keyvault" {
  name                = "pe-${var.akv_config.name}-${var.environment}-${var.locationshort}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.current.name
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = merge({ Name = "pe-${var.akv_config.name}-${var.environment}-${var.locationshort}" })

  private_service_connection {
    name                           = "psc-${var.akv_config.name}-${var.environment}-${var.locationshort}"
    private_connection_resource_id = azurerm_key_vault.akv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
 }