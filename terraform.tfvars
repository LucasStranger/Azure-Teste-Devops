#########################################
# VARIÁVEIS GERAIS DO PROJETO
#########################################

prefix      = "techfusion"          # Nome base para todos os recursos
location    = "eastus"         # Região da Azure
environment = "dev"                 # Ambiente (dev / test / prod)

#########################################
# STORAGE / LOG / EVENT HUB
#########################################

storage_account_suffix     = "st01"      # Sufixo obrigatório (minúsculo, sem números repetidos)
eventhub_partition_count   = 2           # Quantidade de partições do Kafka/EventHub

#########################################
# NETWORK MODULE
#########################################

office_ip_cidr = "0.0.0.0/0"             # Permite acesso público total (troque se quiser restringir)

#########################################
# COMPUTE (VMSS) MODULE
#########################################

admin_username      = "lucas"            # Usuário admin das VMs
ssh_public_key_path = "~/.ssh/id_rsa.pub"   # Caminho da sua chave SSH pública
vm_size             = "Standard_A1_v2"    # Tamanho da VM
instance_count      = 1                  # Quantas VMs no VMSS

#########################################
# DATA MODULE (Cosmos DB / Redis)
#########################################

cosmos_offer_tier = "Standard"           # Tipo de oferta do Cosmos DB
