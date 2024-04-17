resource "terraform_data" "tf_app_deploy" {
  triggers_replace  = [
    { for vm_key, vm_value in ("${module.vm_create}") :
    vm_key => vm_key == "master02" ? "${module.vm_create[vm_key].internal_ip_address02}" :"${module.vm_create[vm_key].internal_ip_address}"   
  }
   ] 
   provisioner "local-exec" {
    command = "ssh -i files/sftest -o StrictHostKeyChecking=no -p \"${var.ssh_port}\" ansible@\"${module.first_master.master01_external_ip_address}\" 'hostname; sudo bash /home/ansible/swarm/run_app.sh'"
  }
}
