output "cosmos_account_name" {
  value = azurerm_cosmosdb_account.cosmos.name
}

output "redis_id" {
  value = azurerm_redis_cache.redis.id
}
