variable "project_name" {}
variable "cost_center" {}
variable "owner" {}
variable "location" {}
variable "resource_group_name" {}
variable "team_ad_group" {}
variable "team_admin_ad_group" {}
variable "vnet_id" {}
variable "subnet_id" {}

resource "azurerm_storage_account" "team_sa" {
  name                     = "${var.project_name}sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.subnet_id]
  }

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}

resource "azurerm_private_endpoint" "team_sa_pe" {
  name                = "${var.project_name}-sa-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.project_name}-sa-psc"
    private_connection_resource_id = azurerm_storage_account.team_sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}

resource "azurerm_role_assignment" "team_sa_role" {
  scope                = azurerm_storage_account.team_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.team_ad_group
}

resource "azurerm_role_assignment" "team_sa_admin_role" {
  scope                = azurerm_storage_account.team_sa.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = var.team_admin_ad_group
}
