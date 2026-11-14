resource "libvirt_domain" "almacen" {
  name      = "almacen"
  memory    = 512
  vcpu      = 1
  cloudinit = libvirt_cloudinit_disk.almacen.id

  network_interface {
    network_id     = libvirt_network.nat.id
    mac            = local.maquinas.almacen.mac_nat
    wait_for_lease = true
  }

  network_interface {
    network_id = libvirt_network.datos.id
    mac        = local.maquinas.almacen.mac_datos
  }

  disk {
    volume_id = libvirt_volume.almacen.id
  }

  disk {
    volume_id = libvirt_volume.datos_almacen.id
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
