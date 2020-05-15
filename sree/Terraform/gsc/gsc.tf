resource "hyperv_virtual_machine" "GSC" {
  count 			 = "${var.VMCount}"
  name               = "GSC${count.index}"
  processors         = "${var.processors}"
  ram                = "${var.ram}"
  use_dynamic_memory =false
  minimum_ram		= "${var.min_ram}"
  maximum_ram		= "${var.ram}"
  switch                = "NIC1"
  generation		= "${var.generation}"
  path                  = "${var.path}"

  storage_disk {
    name                  = "GSC${count.index}"
    image_path      = "${var.Vhdpath}\\GSC${count.index}.vhdx"
	reuse_on_create = true
	delete_on_destroy = true
  }
}