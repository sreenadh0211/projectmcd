data "external" "nicdata" {
 program = ["Powershell", "./importjsondata.ps1"]
}

resource "hyperv_virtual_switch" "application_switch" {
  count = "${data.external.nicdata.result["SwitchCount"]}"
  name  = "NIC${count.index}"
}

resource "hyperv_virtual_machine" "VM" {
  count = "${data.external.nicdata.result["VMCount"]}"
  name               = "VM${count.index}"
  processors         = 2
  ram                = 4096
  use_dynamic_memory =false
  minimum_ram		= 1024
  maximum_ram		= 4096
  switch                = "NIC1"
  generation		= 1
  path                  = "S:\\VirtualLabs\\hyperv"

  storage_disk {
    name                  = "VM${count.index}"
    image_path      = "${data.external.nicdata.result["VM${count.index}"]}"
	reuse_on_create = true
	delete_on_destroy = true
  }
}