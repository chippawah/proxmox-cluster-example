# Prerequisites

- Block of MAC addresses with static IP assignments
- Access to a Proxmox host
- Terraform installed locally (will try to make everything else happen on the proxmox host)

# Creating a Terraform user in Proxmox

From the Proxmox provider docs: https://registry.terraform.io/providers/Telmate/proxmox/latest/docs

### Commands:

Run these commands in the Proxmox shell to generate a user for Terraform to use when provisioning resources.
See the docs above to learn more about creating the user. Ideally this is handled automagically by Ansible. Basically its the following:

- Create a new role, `TerraformProv`, for the future terraform user.
- Create the user `terraform-prov@pve`
- Add the `TerraformProv` role to the terraform-prov user
- Create an API token for the `terraform-prov@pve`

```$sh
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
```
```$sh
pveum user add terraform-prov@pve
```
```$sh
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```
```$sh
pveum user token add terraform-prov@pve terraform-provisioner --privsep 0
```

### Result of the commands:

The last command will output a table similar to the one below. It will contain the API token secret value which will be different from the one below. The values returned here should ideally be saved somewhere like Vault to ensure secure access later when managing resources in Proxmox.

name         | value                                    | provider config value
-------------|------------------------------------------|----------------------
full-tokenid | terraform-prov@pve!terraform-provisioner | `pm_api_token_id`
info         | {"privsep":0}                            | _N/A_
value        | e5d09f8d-XXXX-XXXX-XXXX-a098ddcfd54a     | `pm_api_token_secret`


# Installing Terraform

Following the instructions here: https://learn.hashicorp.com/tutorials/terraform/install-cli

Run the following command block to install the Terraform cli tool on Debian systems.

```$sh
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl ; \
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - ; \
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" ; \
sudo apt-get update && sudo apt-get install terraform ;
```

