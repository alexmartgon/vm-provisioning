provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore-name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# data "vsphere_compute_cluster" "cluster" {
#   name          = "cluster-01"
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}