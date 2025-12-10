# platform module: RG, log analytics, storage, key vault, eventhubs, function app
module "platform" {
  source = "./modules/platform"

  prefix                   = var.prefix
  location                 = var.location
  environment              = var.environment
  storage_account_suffix   = var.storage_account_suffix
  eventhub_partition_count = var.eventhub_partition_count
}

# network module: vnet, subnet, nsg
module "network" {
  source         = "./modules/network"
  prefix         = var.prefix
  location       = var.location
  rg_name        = module.platform.resource_group_name
  office_ip_cidr = var.office_ip_cidr
}

# compute module: public ip, LB, VMSS
module "compute" {
  source              = "./modules/compute"
  prefix              = var.prefix
  location            = var.location
  rg_name             = module.platform.resource_group_name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  vm_size             = var.vm_size
  instance_count      = var.instance_count
}

# data module: cosmos, redis
module "data" {
  source            = "./modules/data"
  prefix            = var.prefix
  location          = var.location
  rg_name           = module.platform.resource_group_name
  cosmos_offer_tier = var.cosmos_offer_tier
}
