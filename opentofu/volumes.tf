resource "libvirt_volume" "base_web" {
  name   = "base-web.qcow2"
  pool   = "default"
  source = var.imagen_base_web
  format = "qcow2"
}

resource "libvirt_volume" "base_bd" {
  name   = "base-bd.qcow2"
  pool   = "default"
  source = var.imagen_base_bd
  format = "qcow2"
}

resource "libvirt_volume" "web" {
  name           = "web.qcow2"
  pool           = "default"
  base_volume_id = libvirt_volume.base_web.id
  size           = 10737418240
}

resource "libvirt_volume" "bd" {
  name           = "bd.qcow2"
  pool           = "default"
  base_volume_id = libvirt_volume.base_bd.id
  size           = 10737418240
}
