resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "${var.prefix}-cosmos"
  location            = var.location
  resource_group_name = var.rg_name
  offer_type          = var.cosmos_offer_tier
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_redis_cache" "redis" {
  name                = "${var.prefix}-redis"
  location            = var.location
  resource_group_name = var.rg_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
}
