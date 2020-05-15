resource "hyperv_virtual_switch" "application_switch" {
  count = "${var.SwitchCount}"
  name  = "NIC${count.index}"
}