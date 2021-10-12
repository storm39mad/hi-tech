variable "vsphere_server" {
	type = string
	default = "vcsa1.ht2021.local"
}               
variable "vsphere_user" {
	type = string
	default = "administrator@ht2021.local"
}

variable "vsphere_password" {
	type = string
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_virtual_machine" "template" {
  name          = "CentOSTM"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datacenter" "dc" {
  name = "DatacenterHT"
}

data "vsphere_datastore" "datastore" {
  name          = "esxi1data1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore2" {
  name          = "esxi2data1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "ClusterHT/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "DPortGroupDMZ"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm1" {
  name             = "k8s1"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  firmware = "efi"
  num_cpus = 4
  memory   = 8192
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    label       = "disk1"
    size        = "20"
    thin_provisioned = true
    unit_number = 1
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    customize {
	linux_options {
		host_name = "k8s1"
		domain = "ht2021.local"
	}
	network_interface {
		ipv4_address = "172.30.1.11"
		ipv4_netmask = 24
	}
	ipv4_gateway = "172.30.1.254"
	dns_server_list = ["172.30.0.1"]
    }
  }
}

resource "vsphere_virtual_machine" "vm2" {
  name             = "k8s2"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  firmware = "efi"
  num_cpus = 4
  memory   = 8192
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    label       = "disk1"
    size        = "20"
    thin_provisioned = true
    unit_number = 1
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    customize {
	linux_options {
		host_name = "k8s2"
		domain = "ht2021.local"
	}
	network_interface {
		ipv4_address = "172.30.1.12"
		ipv4_netmask = 24
	}
	ipv4_gateway = "172.30.1.254"
	dns_server_list = ["172.30.0.1"]
    }
  }
}

resource "vsphere_virtual_machine" "vm3" {
  name             = "k8s3"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore2.id

  firmware = "efi"
  num_cpus = 4
  memory   = 8192
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    label       = "disk1"
    size        = "20"
    thin_provisioned = true
    unit_number = 1
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    customize {
	linux_options {
		host_name = "k8s3"
		domain = "ht2021.local"
	}
	network_interface {
		ipv4_address = "172.30.1.13"
		ipv4_netmask = 24
	}
	ipv4_gateway = "172.30.1.254"
	dns_server_list = ["172.30.0.1"]
    }
  }
}
