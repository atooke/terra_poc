output "name" {
  value = azurerm_storage_account.team_sa.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.team_sa_pe.id
}
