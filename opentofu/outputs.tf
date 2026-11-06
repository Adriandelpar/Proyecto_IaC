output "ips" {
  description = "IP de las máquinas"
  value = {
    web = {
      nat   = libvirt_domain.web[*].network_interface[0].addresses[0]
      datos = [for i in range(var.num_webs) : cidrhost("172.16.0.0/24", 10 + i)]
    }
    bd = {
      nat   = libvirt_domain.bd.network_interface[0].addresses[0]
      datos = "172.16.0.20"
    }
  }
}
