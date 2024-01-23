# vm-provisioning
Terraform Script for deploying a VM in an esxi host.

## Current Goals
- [x] POC.
- The script runs and boots up a ova file ready for work to be performed.
- [x] Passwords Hidden From Repo.
- They are Jenkins environment credentials and passed to terraform as **TF_VARS_** variables.
- [ ] Jenkins file correctly has stages (Approvals??).
- There is a variable setting stage, a plan stage and an applying stage.
- An approval in between would be very cool
- [ ] Creating OVAs for all desired OS's and Architectures.
- Fedora ARM and amd_64 (Currently only amd_64).
- Ubuntu ARM and amd_64.
- **Enable a simpler manner of creating OVAs or use OVFs (Tested and possible)**
- [ ] Terraform script refining.
- Script should allow you to create multiple machines. (**Only planning on OVA to loop through**)
- Script should allow you to define multiple names; CPUs and RAM allocation.
- Script should make an easy to gather output.
- Investigate user data (most of the time not worth worrying about, just embed with Ansible).
- [ ] Script uses ESXI service user to perform task.

## License and copyright notice
The terraform provider used in this Terraform script was developed by Josenk. Thank you very much for your incredible work.

https://github.com/josenk/terraform-provider-esxi
https://registry.terraform.io/providers/josenk/esxi