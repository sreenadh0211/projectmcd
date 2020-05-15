resource "hyperv_virtual_machine" "POS" {
  count 			 = "${var.VMCount}"
  name               = "POS${count.index}"
  processors         = "${var.processors}"
  ram                = "${var.ram}"
  use_dynamic_memory =false
  minimum_ram		= "${var.min_ram}"
  maximum_ram		= "${var.ram}"
  switch                = "NIC1"
  generation		= "${var.generation}"
  path                  = "${var.path}"

  storage_disk {
    name                  = "POS${count.index}"
    image_path      = "${var.Vhdpath}\\POS${count.index}.vhdx"
	reuse_on_create = true
	delete_on_destroy = true
  }
}