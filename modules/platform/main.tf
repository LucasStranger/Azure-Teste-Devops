data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
  tags = {
    project = "TechFusion"
    env     = var.environment
  }
}

resource "azurerm_log_analytics_workspace" "la" {
  name                = "${var.prefix}-la"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  
  tags = {
    project = "TechFusion"
    env     = var.environment
  }
}

resource "azurerm_storage_account" "st" {
  name                     = lower(replace("${var.prefix}${var.storage_account_suffix}", "/[^a-z0-9]/", ""))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  min_tls_version          = "TLS1_2"
  
  tags = {
    project = "TechFusion"
    env     = var.environment
  }
}

resource "azurerm_key_vault" "kv" {
  name                       = "${var.prefix}-kv"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  
  tags = {
    project = "TechFusion"
    env     = var.environment
  }
}

resource "azurerm_eventhub_namespace" "eh_ns" {
  name                = "${var.prefix}-ehns"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  capacity            = 1
  
  tags = {
    project = "TechFusion"
    env     = var.environment
  }
}

resource "azurerm_eventhub" "eh" {
  name                = "${var.prefix}-events"
  
  # O erro pediu explicitamente estes dois campos, então vamos fornecê-los:
  namespace_name      = azurerm_eventhub_namespace.eh_ns.name
  resource_group_name = azurerm_eventhub_namespace.eh_ns.resource_group_name

  partition_count     = var.eventhub_partition_count
  message_retention   = 1
}