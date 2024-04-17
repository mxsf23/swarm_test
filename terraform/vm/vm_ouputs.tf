output "internal_ip_address" {
  value = yandex_compute_instance.worker[*].network_interface.0.ip_address
}

output "external_ip_address" {
  value = yandex_compute_instance.worker[*].network_interface.0.nat_ip_address
}

output "internal_ip_address02" {
  value = yandex_compute_instance.master02[*].network_interface.0.ip_address
}

output "external_ip_address02" {
  value = yandex_compute_instance.master02[*].network_interface.0.nat_ip_address
}


output "vm_hostname" {
  value = yandex_compute_instance.worker[*].hostname
}

output "vm_hostname02" {
  value = yandex_compute_instance.master02[*].hostname
}
