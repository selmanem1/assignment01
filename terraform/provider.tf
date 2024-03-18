terraform {
  required_version = ">=1.0"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id               = data.azurerm_client_config.current.client_id
  client_secret           = data.azurerm_client_config.current.client_secret
  subscription_id         = data.azurerm_client_config.current.subscription_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
}

data "azurerm_client_config" "current" {}
