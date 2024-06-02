provider "azurerm" {
  features {}
}

# Load common variables and tags
module "common_vars" {
  source = "./common"
}

# Merge common and team tags
locals {
  merged_tags = merge(
    module.common_vars.common_tags,
    var.team_tags
  )
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
