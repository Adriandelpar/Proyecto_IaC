variable "imagen_base_web" {
  description = "Imagen base de Debian 13 para el servidor web"
  type        = string
  default     = "/var/lib/libvirt/images/debian-13-generic-amd64.qcow2"
}

variable "imagen_base_bd" {
  description = "Imagen base de Ubuntu 26.04 para el servidor de base de datos"
  type        = string
  default     = "/var/lib/libvirt/images/ubuntu2604-base.qcow2"
}

variable "memoria" {
  description = "Memoria (MiB) de cada máquina"
  type        = number
  default     = 1024
}

variable "usuario" {
  description = "Usuario que se crea en las máquinas"
  type        = string
  default     = "adrian"
}

variable "clave_publica" {
  description = "Ruta de la clave SSH pública que se mete en las máquinas"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1Pll8ZZb/tjVJ7utbE8fKQRFX8+xnG9cbeIeVXClhp adrian@atlas"
}
