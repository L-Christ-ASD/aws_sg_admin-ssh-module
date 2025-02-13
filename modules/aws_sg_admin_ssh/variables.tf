

variable "admin-ips" {
  description = "les ip's des admins"
  default     = ["8.8.8.8", "1.1.1.1"]
}

variable "mon_ip" {
  description = "Les adresses acceptéés"
  type        = string
  default     = "0.0.0.0"
}

variable "vpc_id" {
  description = "l'id du vpc auquel on rattache notre security group"
}



