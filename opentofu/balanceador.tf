resource "libvirt_domain" "balanceador" {
  name      = "balanceador"
  memory    = var.memoria
  vcpu      = 1
  cloudinit = libvirt_cloudinit_disk.balanceador.id

  network_interface {
    network_id     = libvirt_network.nat.id
    mac            = local.maquinas.balanceador.mac_nat
    wait_for_lease = true
  }

  network_interface {
    network_id = libvirt_network.datos.id
    mac        = local.maquinas.balanceador.mac_datos
  }

  disk {
    volume_id = libvirt_volume.balanceador.id
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
