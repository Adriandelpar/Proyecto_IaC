resource "libvirt_domain" "web" {
  count     = var.num_webs
  name      = "web${count.index + 1}"
  memory    = var.memoria
  vcpu      = 1
  cloudinit = libvirt_cloudinit_disk.web[count.index].id

  network_interface {
    network_id     = libvirt_network.nat.id
    mac            = format("52:54:00:10:01:%02x", count.index + 1)
    wait_for_lease = true
  }

  network_interface {
    network_id = libvirt_network.datos.id
    mac        = format("52:54:00:20:01:%02x", count.index + 1)
  }

  disk {
    volume_id = libvirt_volume.web[count.index].id
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
