terraform {
  # Ref: https://registry.terraform.io/providers/vmware/vcd/latest/docs  
  required_providers {
    vcd = {
      source = "VMware/vcd"
      version  = ">= 3.4.0"
    }
  }
}

# Ref: https://registry.terraform.io/providers/vmware/vcd/latest/docs
provider "vcd" {
  user                  = "sccmadmkp11"
  password              = "Pa$$w0rd"
  org                   = "rukavishnikov"
  vdc                   = "vdcrukavishnikov"
  url                   = "https://vcd.kp11.ru/api"
  allow_unverified_ssl  = true
  max_retry_timeout     = 240
}