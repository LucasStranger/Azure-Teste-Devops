output "resource_group" {
  value = module.platform.resource_group_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "lb_public_ip" {
  value = module.compute.lb_public_ip
}

output "vmss_id" {
  value = module.compute.vmss_id
}

# Correção 1: Adicionado o "_name" para bater com o módulo
output "eventhub_namespace" {
  value = module.platform.eventhub_namespace_name
}

output "eventhub_name" {
  value = module.platform.eventhub_name
}

output "storage_account_name" {
  value = module.platform.storage_account_name
}

# Correção 2: O bloco "function_app_name" foi REMOVIDO pois o recurso não existe.

output "cosmos_account" {
  value = module.data.cosmos_account_name
}
