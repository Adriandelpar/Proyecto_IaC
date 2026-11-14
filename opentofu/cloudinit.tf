locals {
  maquinas = {
    bd = {
      mac_nat   = "52:54:00:10:00:02"
      mac_datos = "52:54:00:20:00:02"
      ip_datos  = "172.16.0.20"
    }
    balanceador = {
      mac_nat   = "52:54:00:10:00:03"
      mac_datos = "52:54:00:20:00:03"
      ip_datos  = "172.16.0.5"
    }
    almacen = {
      mac_nat   = "52:54:00:10:00:04"
      mac_datos = "52:54:00:20:00:04"
      ip_datos  = "172.16.0.30"
    }
  }
}

resource "libvirt_cloudinit_disk" "web" {
  count = var.num_webs
  name  = "cloudinit-web${count.index + 1}.iso"
  pool  = "default"

  user_data = templatefile("${path.module}/cloud-init/user_data.tftpl", {
    hostname      = "web${count.index + 1}"
    usuario       = var.usuario
    clave_publica = var.clave_publica
  })

  network_config = templatefile("${path.module}/cloud-init/network_config.tftpl", {
    mac_nat   = format("52:54:00:10:01:%02x", count.index + 1)
    mac_datos = format("52:54:00:20:01:%02x", count.index + 1)
    ip_datos  = cidrhost("172.16.0.0/24", 10 + count.index)
  })
}

resource "libvirt_cloudinit_disk" "bd" {
  name = "cloudinit-bd.iso"
  pool = "default"

  user_data = templatefile("${path.module}/cloud-init/user_data.tftpl", {
    hostname      = "bd"
    usuario       = var.usuario
    clave_publica = var.clave_publica
  })

  network_config = templatefile("${path.module}/cloud-init/network_config.tftpl", {
    mac_nat   = local.maquinas.bd.mac_nat
    mac_datos = local.maquinas.bd.mac_datos
    ip_datos  = local.maquinas.bd.ip_datos
  })
}

resource "libvirt_cloudinit_disk" "balanceador" {
  name = "cloudinit-balanceador.iso"
  pool = "default"

  user_data = templatefile("${path.module}/cloud-init/user_data.tftpl", {
    hostname      = "balanceador"
    usuario       = var.usuario
    clave_publica = var.clave_publica
  })

  network_config = templatefile("${path.module}/cloud-init/network_config.tftpl", {
    mac_nat   = local.maquinas.balanceador.mac_nat
    mac_datos = local.maquinas.balanceador.mac_datos
    ip_datos  = local.maquinas.balanceador.ip_datos
  })
}

resource "libvirt_cloudinit_disk" "almacen" {
  name = "cloudinit-almacen.iso"
  pool = "default"

  user_data = templatefile("${path.module}/cloud-init/user_data.tftpl", {
    hostname      = "almacen"
    usuario       = var.usuario
    clave_publica = var.clave_publica
  })

  network_config = templatefile("${path.module}/cloud-init/network_config.tftpl", {
    mac_nat   = local.maquinas.almacen.mac_nat
    mac_datos = local.maquinas.almacen.mac_datos
    ip_datos  = local.maquinas.almacen.ip_datos
  })
}
