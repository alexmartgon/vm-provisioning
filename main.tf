terraform {
  required_version = ">= 0.13"
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
      #source = "josenk/esxi"
      #
      # For more information, see the provider source documentation:
      # https://github.com/josenk/terraform-provider-esxi
      # https://registry.terraform.io/providers/josenk/esxi
    }
  }
  ### This is more because I want this to be a quick and easy way to deploy ovfs. Without having to keep a state
  ### For different deployments I will use a copy of this file to have a state.
  # backend "local" {
  #   path = "relative/path/to/terraform.tfstate"
  # }
}

provider "esxi" {
  esxi_hostname      = var.vsphere_server
  esxi_username      = var.vsphere_user
  esxi_password      = var.vsphere_password
}

resource "esxi_guest" "vm" {
  ### Get the count of instances to create
  count = length(var.vm-name)
  guest_name         = var.vm-name[count.index]
  disk_store         = var.datastore-name
  boot_firmware      = "efi"
  #  Specify an existing guest to clone, an ovf source, or neither to build a bare-metal guest vm.
  #
  #clone_from_vm      = "Templates/centos7"
  ovf_source        = var.ovf-path
  power             = "on"

  memsize            = var.vm-ram[count.index]
  numvcpus           = var.vm-cpu[count.index]

  network_interfaces {
    virtual_network = "VM Network"
    nic_type = "vmxnet3"
  }

  guest_startup_timeout  = 60
}