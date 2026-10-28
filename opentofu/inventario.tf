resource "local_file" "inventario" {
  filename = "../ansible/inventario.ini"
  content = templatefile("inventario.tftpl", {
    ip_web  = libvirt_domain.web.network_interface[0].addresses[0]
    ip_bd   = libvirt_domain.bd.network_interface[0].addresses[0]
    usuario = var.usuario
  })
}
