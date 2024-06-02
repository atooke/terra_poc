output "id" {
  value = azurerm_virtual_network.team_vnet.id
}

output "key_vault_subnet_id" {
  value = azurerm_subnet.key_vault_subnet.id
}

output "storage_account_subnet_id" {
  value = azurerm_subnet.storage_account_subnet.id
}
