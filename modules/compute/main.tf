resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.prefix}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = "${var.prefix}-lb"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bpool" {
  name            = "${var.prefix}-bpool"
  loadbalancer_id = azurerm_lb.lb.id
  # REMOVIDO: resource_group_name = var.rg_name
}

resource "azurerm_lb_probe" "http_probe" {
  name            = "${var.prefix}-probe"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Http"
  request_path    = "/"
  port            = 80
  # REMOVIDO: resource_group_name = var.rg_name
}

resource "azurerm_lb_rule" "http_rule" {
  name                           = "${var.prefix}-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.bpool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
  # REMOVIDO: resource_group_name = var.rg_name
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.prefix}-vmss"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.vm_size
  instances           = var.instance_count
  admin_username      = var.admin_username
  upgrade_mode        = "Automatic"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  network_interface {
    name    = "vmssnic"
    primary = true

    ip_configuration {
      name                                   = "ipconfig"
      subnet_id                              = var.subnet_id
      primary                                = true
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpool.id]
    }
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)   # ← CORRIGIDO AQUI
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl enable nginx

    cat > /var/www/html/index.html <<'HTML'
    <html>
      <body>
        <h1>TechFusion - VMSS Instance $(hostname)</h1>
      </body>
    </html>
    HTML

    systemctl restart nginx
  EOF
  )
}