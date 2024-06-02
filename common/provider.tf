provider "azurerm" {
  features {}
}


provider "azurerm" {
  features {}
  subscription_id   = "043012a7-65c4-4f49-8558-637dec180441"
  tenant_id = "da67ef1b-ca59-4db2-9a8c-aa8d94617a16"
  client_id = "3aa69d89-aaa8-4909-9985-51c15db808b5" #mt-mlops-iac
  client_secret = "Czs8Q~-xxxxxx"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}



data "azurerm_client_config" "current" {}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "location" {
  value = "East US"
}
