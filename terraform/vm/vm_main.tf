resource "yandex_compute_instance" "worker" {
  name = var.hostname
  hostname = var.hostname
  count = var.role == "worker" ? 1 : 0

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = 40
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
    user-data = var.worker_user_data
    role = var.role
  }
  
}

resource "yandex_compute_instance" "master02" {
  name = var.hostname
  hostname = var.hostname
  count = var.role == "worker" ? 0 : 1

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
    user-data = var.master_user_data
  }
  
}
