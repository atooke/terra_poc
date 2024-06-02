variable "project_name" {}
variable "cost_center" {}
variable "owner" {}
variable "location" {}

resource "azurerm_resource_group" "team_rg" {
  name     = "rg-${var.project_name}"
  location = var.location

  tags = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }

  
}
