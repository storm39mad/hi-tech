
resource "vcd_vapp" "web" {
  name = "web"

}

resource "vcd_vapp_network" "vappNet" {

  name               = "NetvAPP"
  vapp_name          = vcd_vapp.web.name
  gateway            = "192.168.2.1"
  netmask            = "255.255.255.0"

  static_ip_pool {
    start_address = "192.168.2.51"
    end_address   = "192.168.2.100"
  }

}

resource "vcd_vapp_vm" "TestVm" {

  vapp_name = vcd_vapp.web.name


  name = "TestVm"
  catalog_name  = "TM_VM"
  template_name = "vCD_CentOS_Stream_8"
  cpus          = 2
  memory        = 2048

  network {
    name               = vcd_vapp_network.vappNet.name
    type               = "vapp"
    ip_allocation_mode = "POOL"
    is_primary         = true
  }
}