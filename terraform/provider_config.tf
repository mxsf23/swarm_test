terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.115.0"
    }
  }
  backend "s3" {
    endpoints   = { 
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "sf-tf-state02"
    region     = "ru-central1"
    key        = "docker_pg02.tfstate"
    access_key = <access_key>
    secret_key = <secret_key>

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum  = true
  }

}



provider "yandex" {
  token = chomp(file("/opt/git_projects/b48/mvsa_token"))  
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

