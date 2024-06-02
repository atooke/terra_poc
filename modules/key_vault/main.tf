variable "project_name" {}
variable "cost_center" {}
variable "owner" {}
variable "location" {}
variable "resource_group_name" {}
variable "tenant_id" {}
variable "team_ad_group" {}
variable "team_admin_ad_group" {}
variable "vnet_id" {}
variable "subnet_id" {}

resource "azurerm_key_vault" "team_kv" {
  name                = "${var.project_name}-kv"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  network_acls {
    default_action = "Deny"
    bypass = "AzureServices"
    virtual_network_subnet_ids = [var.subnet_id]
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.team_ad_group
    key_permissions = [
      "get", "list", "create", "delete", "update", "import", "backup", "restore", "recover", "purge"
    ]
    secret_permissions = [
      "get", "list", "set", "delete", "backup", "restore", "recover", "purge"
    ]
    certificate_permissions = [
      "get", "list", "delete", "create", "import", "update", "managecontacts",
      "getissuers", "listissuers", "setissuers", "deleteissuers", "manageissuers",
      "recover", "purge"
    ]
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.team_admin_ad_group
    key_permissions = [
      "all"
    ]
    secret_permissions = [
      "all"
    ]
    certificate_permissions = [
      "all"
    ]
  }

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}

resource "azurerm_private_endpoint" "team_kv_pe" {
  name                = "${var.project_name}-kv-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.project_name}-kv-psc"
    private_connection_resource_id = azurerm_key_vault.team_kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}
