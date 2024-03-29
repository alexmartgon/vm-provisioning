variable "vsphere_server" {}
variable "vsphere_user" {}
variable "vsphere_password" {}

variable "datastore-name"{
    type = string
    default = "datastore1"
}

variable "ovf-path"{
    type = string
}

variable "vm-name" {
    type = list(string)
}

variable "vm-ram" {
    type = list(number)
}

variable "vm-cpu" {
    type = list(number)
}