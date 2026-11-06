locals {
  maquinas = {
    bd = {
      mac_nat   = "52:54:00:10:00:02"
      mac_datos = "52:54:00:20:00:02"
      ip_datos  = "172.16.0.20"
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
