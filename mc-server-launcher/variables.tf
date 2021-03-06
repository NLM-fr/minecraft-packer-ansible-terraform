variable "public_key_path" {
  description = "Path to the public SSH key you want to bake into the instance."
  default     = "/root/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "/root/.ssh/id_rsa"
}

variable "project_name" {
  description = "Name of your GCP project.  Example: minecraft"
  default     = "minecraft"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "root"
}
