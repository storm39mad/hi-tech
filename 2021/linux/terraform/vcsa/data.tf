provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "DatacenterHT"
}

data "vsphere_datastore" "ds1" {
  name          = "esxi1data1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds2" {
  name          = "esxi2data1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "ClusterHT/Resources/kubernetes"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "DPortGroupDMZ"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "CentOSTM"
  datacenter_id = data.vsphere_datacenter.dc.id
}
