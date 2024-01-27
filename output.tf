output "ip" {
  value = [esxi_guest.vm[*].ip_address]
}