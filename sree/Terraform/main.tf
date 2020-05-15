data "external" "nicdata" {
 program = ["Powershell", "./importPayload.ps1"]
}

module "network" {
	source = "./Network"
	SwitchCount = "${data.external.nicdata.result["SwitchCount"]}"
	
}
module "kvs" {
	source = "./kvs"
	path                  = "${data.external.nicdata.result["path"]}"
	ram                  = "${data.external.nicdata.result["ram"]}"
	processors                  = "${data.external.nicdata.result["processors"]}"
	min_ram                  = "${data.external.nicdata.result["min_ram"]}"
	generation                  = "${data.external.nicdata.result["generation"]}"
	Vhdpath                  = "${data.external.nicdata.result["destVhdpath"]}"
	VMCount                  = "${data.external.nicdata.result["kvsVMCount"]}"
}

module "gsc" {
	source = "./gsc"
	path                  = "${data.external.nicdata.result["path"]}"
	ram                  = "${data.external.nicdata.result["gscRam"]}"
	processors                  = "${data.external.nicdata.result["processors"]}"
	min_ram                  = "${data.external.nicdata.result["min_ram"]}"
	generation                  = "${data.external.nicdata.result["generation"]}"
	Vhdpath                  = "${data.external.nicdata.result["destVhdpath"]}"
	VMCount                  = "${data.external.nicdata.result["gscVMCount"]}"
}

module "pos" {
	source = "./pos"
	path                  = "${data.external.nicdata.result["path"]}"
	ram                  = "${data.external.nicdata.result["ram"]}"
	processors                  = "${data.external.nicdata.result["processors"]}"
	min_ram                  = "${data.external.nicdata.result["min_ram"]}"
	generation                  = "${data.external.nicdata.result["generation"]}"
	Vhdpath                  = "${data.external.nicdata.result["destVhdpath"]}"
	VMCount                  = "${data.external.nicdata.result["posVMCount"]}"
}
