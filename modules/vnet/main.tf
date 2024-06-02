variable "project_name" {}
variable "cost_center" {}
variable "owner" {}
variable "location" {}
variable "resource_group_name" {}

resource "azurerm_virtual_network" "team_vnet" {
  name                = "${var.project_name}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}

resource "azurerm_subnet" "key_vault_subnet" {
  name                 = "keyvault-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.team_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "keyvault-delegation"
    service_delegation {
      name    = "Microsoft.KeyVault/vaults"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}

resource "azurerm_subnet" "storage_account_subnet" {
  name                 = "storageaccount-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.team_vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "storage-delegation"
    service_delegation {
      name    = "Microsoft.Storage/storageAccounts"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}

output "id" {
  value = azurerm_virtual_network.team_vnet.id
}

output "key_vault_subnet_id" {
  value = azurerm_subnet.key_vault_subnet.id
}

output "storage_account_subnet_id" {
  value = azurerm_subnet.storage_account_subnet.id
}
