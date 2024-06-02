provider "azurerm" {
  features {}
}

# Load common variables
module "common_tags" {
  source = "./common"
}

variable "project_name" {}
variable "cost_center" {}
variable "owner" {}
variable "team_ad_group" {}
variable "team_admin_ad_group" {}

# Load variables from the tfvars file
variable "config" {
  type = map(string)
  default = {
    project_name        = var.project_name
    team_ad_group       = var.cost_center
    team_admin_ad_group = var.team_admin_ad_group
    team_tags = {
      business_unit       = var.team_tags["business_unit"]
      cost_center         = var.team_tags["cost_center"]
      owner               = var.team_tags["owner"]
    }
  }
}

# merge common tags with team tags:
locals {
  tags = merge(module.common_vars.tags, var.config.team_tags)

}








# Resource Group
module "resource_group" {
  source       = "./modules/resource_group"
  project_name = var.config.project_name
  cost_center  = var.config.cost_center
  owner        = var.config.owner
  location     = module.common_vars.location
}

# VNet and Subnets
module "vnet" {
  source              = "./modules/vnet"
  project_name        = var.config.project_name
  cost_center         = var.config.cost_center
  owner               = var.config.owner
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
}

# Key Vault
module "key_vault" {
  source              = "./modules/key_vault"
  project_name        = var.config.project_name
  cost_center         = var.config.cost_center
  owner               = var.config.owner
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = module.common_vars.tenant_id
  team_ad_group       = var.config.team_ad_group
  team_admin_ad_group = var.config.team_admin_ad_group
  vnet_id             = module.vnet.id
  subnet_id           = module.vnet.key_vault_subnet_id
}

# Storage Account
module "storage_account" {
  source              = "./modules/storage_account"
  project_name        = var.config.project_name
  cost_center         = var.config.cost_center
  owner               = var.config.owner
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  team_ad_group       = var.config.team_ad_group
  team_admin_ad_group = var.config.team_admin_ad_group
  vnet_id             = module.vnet.id
  subnet_id           = module.vnet.storage_account_subnet_id
}
