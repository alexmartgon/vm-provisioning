# vm-provisioning
Terraform Script for deploying a VM in an esxi host.

## Current Goals
- [x] POC.
- The script runs and boots up a ova file ready for work to be performed.
- [x] Passwords Hidden From Repo.
- They are Jenkins environment credentials and passed to terraform as **TF_VARS_** variables.
- [x] Script uses ESXI service user to perform task.
- [ ] Jenkins file correctly has stages (Approvals??).
- There is a variable setting stage, a plan stage and an applying stage.
- An approval in between would be very cool
- [ ] Terraform script refining.
- Script should allow you to create multiple machines. (**Only planning one OVA to loop through can add more but seems like a hastle for the tfvars file**)
- Script should allow you to define multiple names; CPUs and RAM allocation.
- Script should make it easy to gather output.
- Investigate user data (most of the time not worth worrying about, just embed with Ansible).
- [ ] Creating OVAs for all desired OS's and Architectures. **(Will do as required)**
- Fedora ARM and amd_64 (Currently only amd_64).
- Ubuntu ARM and amd_64.
- Windows 10 ova?
- **Enable a simpler manner of creating OVAs or use OVFs (Tested and possible)**

## License and copyright notice
The Terraform provider used in this Terraform script was developed by Josenk. Thank you very much for your incredible work.

https://github.com/josenk/terraform-provider-esxi
https://registry.terraform.io/providers/josenk/esxi