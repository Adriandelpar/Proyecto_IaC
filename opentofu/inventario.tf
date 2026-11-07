resource "local_file" "inventario" {
  filename = "../ansible/inventario.ini"
  content = templatefile("inventario.tftpl", {
    ips_web        = libvirt_domain.web[*].network_interface[0].addresses[0]
    ips_datos_web  = [for i in range(var.num_webs) : cidrhost("172.16.0.0/24", 10 + i)]
    ip_bd          = libvirt_domain.bd.network_interface[0].addresses[0]
    ip_balanceador = libvirt_domain.balanceador.network_interface[0].addresses[0]
    usuario        = var.usuario
  })
}
