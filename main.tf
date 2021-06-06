terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  zone            = "fr-par-1"
  region          = "fr-par"
}

resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_volume" "data" {
  size_in_gb = 20
  type = "l_ssd"
}

resource "scaleway_instance_server" "my-instance" {
  type  = "DEV1-S"
  image = "ubuntu_focal"
  name = "minecraft-01"

  tags = [ "minecraft instance" ]
  
  ip_id = scaleway_instance_ip.public_ip.id
  
provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file(var.ssh_key_private)}"
      host        = "${scaleway_instance_ip.public_ip.address}"
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${scaleway_instance_ip.public_ip.address}, --private-key ${var.ssh_key_private} minecraft.yaml"
  }
}

output "public_ip" {
  value = scaleway_instance_ip.public_ip.address
}

