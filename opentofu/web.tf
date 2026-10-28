resource "libvirt_domain" "web" {
  name      = "web"
  memory    = var.memoria
  vcpu      = 1
  cloudinit = libvirt_cloudinit_disk.web.id

  network_interface {
    network_id     = libvirt_network.nat.id
    mac            = local.maquinas.web.mac_nat
    wait_for_lease = false
  }

  network_interface {
    network_id = libvirt_network.datos.id
    mac        = local.maquinas.web.mac_datos
  }

  disk {
    volume_id = libvirt_volume.web.id
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
