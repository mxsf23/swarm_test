variable "YC_FOLDER_ID" {
  type = string
  default = env("YC_FOLDER_ID")
}

variable "YC_ZONE" {
  type = string
  default = env("YC_ZONE")
}

variable "YC_SUBNET_ID" {
  type = string
  default = env("YC_SUBNET_ID")
}

source "yandex" "ubuntu-docker" {
  folder_id           = "${var.YC_FOLDER_ID}"
  source_image_family = "ubuntu-2204-lts"
  ssh_username        = "ubuntu"
  use_ipv4_nat        = "true"
  image_description   = "Yandex Cloud Ubuntu Image with Docker"
  image_family        = "ubuntu-2204-docker"
  image_name          = "ubuntu-docker"
  subnet_id           = "${var.YC_SUBNET_ID}"
  disk_type           = "network-hdd"
  zone                = "${var.YC_ZONE}"

}

build {
  sources = ["source.yandex.ubuntu-docker"]

  provisioner "shell" {
    inline = [
        "sudo apt-get -y update",
        "sudo apt-get -y install python3 ca-certificates curl vim mc software-properties-common apt-transport-https",
        "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc",
        "sudo chmod a+r /etc/apt/keyrings/docker.asc",
        "sudo  echo \"deb [signed-by=/etc/apt/keyrings/docker.asc]  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
        "sudo apt-get -y update",
        "sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",

        # Test - Check versions for installed components
        "echo '=== Tests Start ==='", 
        "sudo docker version",
        "echo '=== Tests End ==='",
        "sudo cloud-init clean"
    ]
  }
}
