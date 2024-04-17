output "master01_internal_ip_address" {
  value = yandex_compute_instance.master01.network_interface.0.ip_address
}

output "master01_external_ip_address" {
  value = yandex_compute_instance.master01.network_interface.0.nat_ip_address
}


output "master01_hostname" {
  value = yandex_compute_instance.master01.hostname
}

output "swarm_key" {
  value = "${data.external.swarm_token.result.token}"
}