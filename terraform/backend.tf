terraform {
  backend "azurerm" {
    resource_group_name   = "devrg1"
    storage_account_name  = "stortfstateXXX"
    container_name        = "state01"
    key                   = "terraform.tfstate"
    subscription_id       = data.azurerm_client_config.current.subscription_id
    client_id             = data.azurerm_client_config.current.client_id
    client_secret         = data.azurerm_client_config.current.client_secret
    tenant_id             = data.azurerm_client_config.current.tenant_id
  }
}

data "azurerm_client_config" "current" {}

