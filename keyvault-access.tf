#Role assignmnent for SPN
resource "azurerm_role_assignment" "kv-pipelinerole" {
  scope                = azurerm_key_vault.akv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}
#role assignment for Key Vault in Project
resource "azurerm_role_assignment" "kv-uai" {
  scope                = azurerm_key_vault.akv.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
}

resource "azurerm_key_vault_access_policy" "subscription_kv_access" {
  key_vault_id = azurerm_key_vault.akv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "Create",
    "List",
    "Update"
  ]

  secret_permissions = [
    "Get",
    "Set",
    "List",
    "Delete",
    "Purge",
    "Recover",
    "Restore"
  ]
}

resource "azurerm_key_vault_access_policy" "group_kvap" {
  key_vault_id = azurerm_key_vault.akv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.cloudadmin_objectid

  key_permissions = [
    "Get",
    "List"
  ]

  secret_permissions = [
    "Get",
    "List"
  ]
}

resource "azurerm_key_vault_access_policy" "cskvapuai"  {
  key_vault_id            = azurerm_key_vault.akv.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.uai.principal_id
  key_permissions         = [ "Get", "Create", "List", "Update", ]
  secret_permissions      = [ "Get", "Set",  "List", "Delete",]
  certificate_permissions = [ "Get", "Create", "Update",  "List", "Import", ]
}