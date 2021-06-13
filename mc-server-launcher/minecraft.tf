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

data "scaleway_instance_image" "ubuntu-minecraft-server" {
  architecture = "x86_64"
  name         = "ubuntu-minecraft-server"
}

#resource "scaleway_account_ssh_key" "mc-launch-from-image" {
#    name        = "mc-launch-from-image"
#    public_key = "${file(var.public_key_path)}"
#}  

resource "scaleway_instance_server" "ubuntu-minecraft-server" {
  name  = "minecraft-server01"
  ip_id = scaleway_instance_ip.public_ip.id
  image = data.scaleway_instance_image.ubuntu-minecraft-server.id
  type  = "DEV1-S"
  security_group_id = scaleway_instance_security_group.web.id

  provisioner "remote-exec" {
    inline = [
      "echo 'SSH has been established'",
      "echo 'starting minecraft server'",
      "systemctl start minecraft-server",
    ]

    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file(var.private_key_path)}"
      host        = "${scaleway_instance_ip.public_ip.address}"
    }
  }
}

resource "scaleway_instance_security_group" "web" {
  name        = "http"
  description = "allow HTTP and HTTPS traffic"

  inbound_rule {
    action = "accept"
    port = 80
    ip_range = "0.0.0.0/0"
    protocol = "TCP"
  }
   inbound_rule {
    action = "accept"
    port = 443
    ip_range = "0.0.0.0/0"
    protocol = "TCP"
  }
  inbound_rule {
    action = "accept"
    port = 25565
    ip_range = "0.0.0.0/0"
    protocol = "TCP"
  }
}

output "ip" {
  value = scaleway_instance_ip.public_ip.address
  }
