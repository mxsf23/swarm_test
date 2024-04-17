terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.115.0"
      configuration_aliases = [ yandex.primary ]
    }
  }
}
