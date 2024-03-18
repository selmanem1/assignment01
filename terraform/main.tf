resource "azurerm_container_registry" "dev_acr" {
  name                     = "devacr"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Standard"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "var.aks_cluster_name" 
  dns_prefix          = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  node_resource_group = "${var.aks_cluster_name}_rg_aks-001"  

  default_node_pool {
    name               = "default"
    vm_size            = "Standard_DS2_v3"
    zones  = var.zones
    vnet_subnet_id     = <subnet.id>

    # Node Auto-Scaling
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    max_pods            = 30
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard" 
  }

  role_based_access_control {
    enabled = true
  }
  oms_agent {
    enabled=true
    log_analytics_workspace_id = <workspaceid>
  }


  tags = {
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     =  azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.dev_acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_postgresql_flexible_server" "pg_server" {
  name                   = "${var.servername}-server"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "12"
  administrator_login    = "var.admin_username"
  administrator_password = "var.admin_password"
  zone                   = "1"
  storage_mb             = 131072
  sku_name               = "GP_Standard_D2s_v3"
  backup_retention_days  = 7

  tags = {
   environment = var.environment
   owner       = var.owner
 }
}
