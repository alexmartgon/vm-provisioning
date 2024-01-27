output "ip" {
  description = "VM's created Name, Private IP, RAM, CPU and Disk Space"
  value = [esxi_guest.vm[*].guest_name, esxi_guest.vm[*].ip_address, esxi_guest.vm[*].memsize, esxi_guest.vm[*].numvcpus, esxi_guest.vm[*].boot_disk_size]
}