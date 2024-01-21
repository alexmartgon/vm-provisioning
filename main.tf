# provider "vsphere" {
#   user                 = var.vsphere_user
#   password             = var.vsphere_password
#   vsphere_server       = var.vsphere_server
#   allow_unverified_ssl = true
# }

# data "vsphere_datacenter" "datacenter" {
#   name = "ha-datacenter"
# }

# data "vsphere_datastore" "datastore" {
#   name          = var.datastore-name
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# data "vsphere_resource_pool" "default" {
#   #name          = "https://10.0.0.147/Resources"  
#   name          = "localhost.hsd1.co.comcast.net/Resources"
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# data "vsphere_host" "host" {
#   name          = "localhost.hsd1.co.comcast.net"
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# data "vsphere_network" "network" {
#   name          = "VM Network"
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# data "vsphere_ovf_vm_template" "ovfLocal" {
#   name              = var.vm-name
#   disk_provisioning = "thin"
#   resource_pool_id  = data.vsphere_resource_pool.default.id
#   datastore_id      = data.vsphere_datastore.datastore.id
#   host_system_id    = data.vsphere_host.host.id
#   local_ovf_path    = var.ovf-path
#   ovf_network_map = {
#     "VM Network" : data.vsphere_network.network.id
#   }
# }

# ## Deployment of VM from Local OVF
# resource "vsphere_virtual_machine" "vmFromLocalOvf" {
#   name                 = var.vm-name
#   datacenter_id        = data.vsphere_datacenter.datacenter.id
#   datastore_id         = data.vsphere_datastore.datastore.id
#   host_system_id       = data.vsphere_host.host.id
#   resource_pool_id     = data.vsphere_resource_pool.default.id
#   num_cpus             = data.vsphere_ovf_vm_template.ovfLocal.num_cpus
#   num_cores_per_socket = data.vsphere_ovf_vm_template.ovfLocal.num_cores_per_socket
#   memory               = data.vsphere_ovf_vm_template.ovfLocal.memory
#   guest_id             = data.vsphere_ovf_vm_template.ovfLocal.guest_id
#   //firmware             = data.vsphere_ovf_vm_template.ovfRemote.firmware
#   scsi_type            = data.vsphere_ovf_vm_template.ovfLocal.scsi_type
#   nested_hv_enabled    = data.vsphere_ovf_vm_template.ovfLocal.nested_hv_enabled
#   dynamic "network_interface" {
#     for_each = data.vsphere_ovf_vm_template.ovfLocal.ovf_network_map
#     content {
#       network_id = network_interface.value
#     }
#   }
#   wait_for_guest_net_timeout = 0
#   wait_for_guest_ip_timeout  = 0

#   ovf_deploy {
#     allow_unverified_ssl_cert = false
#     local_ovf_path            = data.vsphere_ovf_vm_template.ovfLocal.local_ovf_path
#     disk_provisioning         = data.vsphere_ovf_vm_template.ovfLocal.disk_provisioning
#     ovf_network_map           = data.vsphere_ovf_vm_template.ovfLocal.ovf_network_map
#   }

# #   vapp {
# #     properties = {
# #       "guestinfo.hostname"  = "nested-esxi-02.example.com",
# #       "guestinfo.ipaddress" = "172.16.11.102",
# #       "guestinfo.netmask"   = "255.255.255.0",
# #       "guestinfo.gateway"   = "172.16.11.1",
# #       "guestinfo.dns"       = "172.16.11.4",
# #       "guestinfo.domain"    = "example.com",
# #       "guestinfo.ntp"       = "ntp.example.com",
# #       "guestinfo.password"  = "VMware1!",
# #       "guestinfo.ssh"       = "True"
# #     }
# #   }

# #   lifecycle {
# #     ignore_changes = [
# #       annotation,
# #       disk[0].io_share_count,
# #       disk[1].io_share_count,
# #       disk[2].io_share_count,
# #       vapp[0].properties,
# #     ]
# #   }
# }
terraform {
  required_version = ">= 0.13"
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
      #
      # For more information, see the provider source documentation:
      # https://github.com/josenk/terraform-provider-esxi
      # https://registry.terraform.io/providers/josenk/esxi
    }
  }
}

provider "esxi" {
  esxi_hostname      = var.vsphere_server
  esxi_username      = var.vsphere_user
  esxi_password      = var.vsphere_password
}

resource "esxi_guest" "vmtest" {
  guest_name         = var.vm-name
  disk_store         = var.datastore-name
  boot_firmware      = "efi"
  #  Specify an existing guest to clone, an ovf source, or neither to build a bare-metal guest vm.
  #
  #clone_from_vm      = "Templates/centos7"
  ovf_source        = var.ovf-path
  power             = "on"

  network_interfaces {
    virtual_network = "VM Network"
    nic_type = "vmxnet3"
  }

  guest_startup_timeout  = 60
}