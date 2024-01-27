output "vm-info" {
  description = "VM's created Name, Private IP, RAM, CPU."
  value = [esxi_guest.vm[*].guest_name, esxi_guest.vm[*].ip_address, esxi_guest.vm[*].memsize, esxi_guest.vm[*].numvcpus]
}