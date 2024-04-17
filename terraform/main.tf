module "first_master" {
  source = "./first_master"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
  sa_id     = var.sa_id
  ssh_port  = var.ssh_port

  subnet_id = "${module.network.subnet_id}"
  network_id = "${module.network.network_id}"
  ssh_keys = "ubuntu:${file("files/sftest.pub")}" // Path to ssh-key file
  user_data = templatefile("scripts/user-data-master.yaml", {
    ssh_pub_key = "${file("files/sftest.pub")}",
  })
  priv_key = "${file("files/sftest")}"

  providers = {
    yandex.primary = yandex
  }
  name = local.master01.master01.hostname
  hostname = local.master01.master01.hostname
  image_id = local.master01.master01.image_id
  role = local.master01.master01.role
}

module "vm_create" {
  source = "./vm"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
  sa_id     = var.sa_id
  ssh_port  = var.ssh_port
  

  subnet_id = "${module.network.subnet_id}"
  network_id = "${module.network.network_id}"
  ssh_keys = "ubuntu:${file("files/sftest.pub")}" // Path to ssh-key file
  priv_key = "${file("files/sftest")}"
  master_user_data = templatefile("scripts/user-data-master.yaml", {ssh_pub_key = "${file("files/sftest")}",})
  worker_user_data =  templatefile("scripts/user-data-worker.yaml", {
        ssh_pub_key = "${file("files/sftest.pub")}",
        swarm_token = "${module.first_master.swarm_key}",
        first_master_int_ip = "${module.first_master.master01_internal_ip_address}",
    })

  providers = {
    yandex.primary = yandex
  }
  for_each = local.vms
  name = each.key
  hostname = each.value.hostname
  image_id = each.value.image_id
  role = each.value.role
}

module "network" {
  source = "./network"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
  sa_id     = var.sa_id
  network_name = var.network_name
  subnet_name = var.subnet_name
  v4_cidr_blocks = var.v4_cidr_blocks

  providers = {
    yandex.primary = yandex
  }
}
