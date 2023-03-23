  
resource "vsphere_virtual_machine" "k8s1" {
    name             = "k8s1"
    resource_pool_id = data.vsphere_resource_pool.pool.id
    datastore_id     = data.vsphere_datastore.ds1.id

    num_cpus = 4
    memory   = 4096
    firmware = "efi"
    guest_id = data.vsphere_virtual_machine.template.guest_id
    scsi_type = data.vsphere_virtual_machine.template.scsi_type

    network_interface {
        network_id   = data.vsphere_network.network.id
        adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }

    disk {
        label            = "disk0"
        size             = data.vsphere_virtual_machine.template.disks.0.size
        eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
        thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
    }

    clone {
      template_uuid = data.vsphere_virtual_machine.template.id
      customize {
        linux_options {
          host_name = "k8s1"
          domain = "ht2021.local"
        }
        network_interface {
          ipv4_address = "172.30.1.21"
          ipv4_netmask = 24
        }
        ipv4_gateway = "172.30.1.254"
        dns_server_list = [ "172.30.0.1" ]
      }
    }
}