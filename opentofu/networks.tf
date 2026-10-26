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

resource "libvirt_network" "datos" {
  name      = "red_datos"
  mode      = "none"
  addresses = ["172.16.0.0/24"]

  dhcp {
    enabled = false
  }

  dns {
    enabled = false
  }
}
