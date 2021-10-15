  variable "vsphere_user" {
      type = string
      default = "administrator@vsphere.local"
  }

  variable "vsphere_server" {
    type = string
    default = "vcsa1.ht2021.local"
  }

  variable "vsphere_password" {
    type = string
  }