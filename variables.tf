# variables.tf
variable "instance_name" {
  description = "Nom de l'instance EC2"
  type        = string
  default     = "tploic"
}

variable "public_key" {
  description = "Clé publique pour l'accès à l'instance"
  type        = string
  default     = "/home/lortega/.ssh/ma_cle_rsa.pub"
}
