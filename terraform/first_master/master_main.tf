resource "yandex_compute_instance" "master01" {
  name = var.hostname
  hostname = var.hostname

  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = 20
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = var.ssh_keys
    user-data = var.user_data
    role = var.role
  }
  
  provisioner "remote-exec" {
  inline = [
    "sudo docker swarm init",
    "mkdir -p home/ansible/swarm"
    ]
  connection {
    host        = self.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = "ansible"
    port        = var.ssh_port
    private_key = var.priv_key
    timeout     = "10m"
  }    
 }

  connection {
    host        = self.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = "ansible"
    port        = var.ssh_port
    private_key = var.priv_key
    timeout     = "10m"
  }
  provisioner "file" {
    source      = "deploy/swarm"   
    destination = "/home/ansible/swarm"
  }

}

data "external" "swarm_token" {
  program = ["bash","scripts/get_swarm_key.sh", yandex_compute_instance.master01.network_interface.0.nat_ip_address, var.ssh_port ]

}

