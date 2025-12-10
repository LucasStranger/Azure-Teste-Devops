output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.la.id
}

output "storage_account_id" {
  value = azurerm_storage_account.st.id
}

output "storage_account_name" {
  value = azurerm_storage_account.st.name
}

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.eh_ns.name
}

output "eventhub_name" {
  value = azurerm_eventhub.eh.name
}