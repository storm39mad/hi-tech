data "vcd_network_routed" "net" {
  name = "local"
}

resource "vcd_vapp" "web2" {
  name = "web2"
}

resource "vcd_vapp_org_network" "routed-net" {
  vapp_name        = vcd_vapp.web2.name
  org_network_name = data.vcd_network_routed.net.name
}


resource "vcd_vapp_vm" "TestVm2" {

  vapp_name = vcd_vapp.web2.name


  name = "TestVm2"
  catalog_name  = "TM_VM"
  template_name = "vCD_CentOS_Stream_8"
  cpus          = 2
  memory        = 2048

  network {
    name               = vcd_vapp_org_network.routed-net.org_network_name
    type               = "org"
    ip_allocation_mode = "POOL"
    is_primary         = true
  }
}