data "yandex_compute_image" "image01" {
  # family = "ubuntu-2204-docker"
  name = var.image
}

data "yandex_compute_image" "image02" {
  family = "centos-stream-8"
}

locals {
  master01 = {
    "master01" = {
        hostname                = "vm-manage-01"
        image_id                = "${data.yandex_compute_image.image01.id}"
        role                    = "master"
        }
    }
  }

locals { 
  vms = {
    "worker01" = {
        hostname                = "vm-worker-01"
        image_id                = "${data.yandex_compute_image.image01.id}"
        role                    = "worker"
        }
    "worker02" = {
        hostname                = "vm-worker-02"
        image_id                = "${data.yandex_compute_image.image01.id}"
        role                    = "worker"
        }
    }
}
