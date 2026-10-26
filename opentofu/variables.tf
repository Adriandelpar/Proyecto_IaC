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
