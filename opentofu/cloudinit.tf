locals {
  maquinas = {
    web = {
      mac_nat   = "52:54:00:10:00:01"
      mac_datos = "52:54:00:20:00:01"
      ip_datos  = "172.16.0.10"
    }
    bd = {
      mac_nat   = "52:54:00:10:00:02"
      mac_datos = "52:54:00:20:00:02"
      ip_datos  = "172.16.0.20"
    }
  }
}

resource "libvirt_cloudinit_disk" "web" {
  name = "cloudinit-web.iso"
  pool = "default"

  user_data = templatefile("${path.module}/cloud-init/user_data.tftpl", {
    hostname      = "web"
    usuario       = var.usuario
    clave_publica = trimspace(file(pathexpand(var.clave_publica)))
  })

  network_config = templatefile("${path.module}/cloud-init/network_config.tftpl", {
    mac_nat   = local.maquinas.web.mac_nat
    mac_datos = local.maquinas.web.mac_datos
    ip_datos  = local.maquinas.web.ip_datos
  })
}

resource "libvirt_cloudinit_disk" "bd" {
  name = "cloudinit-bd.iso"
  pool = "default"

  user_data = templatefile("${path.module}/cloud-init/user_data.tftpl", {
    hostname      = "bd"
    usuario       = var.usuario
    clave_publica = trimspace(file(pathexpand(var.clave_publica)))
  })

  network_config = templatefile("${path.module}/cloud-init/network_config.tftpl", {
    mac_nat   = local.maquinas.bd.mac_nat
    mac_datos = local.maquinas.bd.mac_datos
    ip_datos  = local.maquinas.bd.ip_datos
  })
}
