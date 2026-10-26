resource "libvirt_network" "nat" {
  name      = "red_nat"
  mode      = "nat"
  domain    = "nat.local"
  addresses = ["192.168.133.0/24"]

  dhcp {
    enabled = true
  }

  dns {
    enabled = true
  }
}
