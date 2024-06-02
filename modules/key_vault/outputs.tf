output "name" {
  value = azurerm_key_vault.team_kv.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.team_kv_pe.id
}
