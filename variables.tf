variable "proxmox_api_token_id" {
    description = "The ID of the API token used for authentication with the Proxmox API."
    type = string
}

variable "proxmox_api_token_secret" {
    description = "The secret value of the token used for authentication with the Proxmox API."
    type = string
}

variable "proxmox_host_node" {
    description = "The name of the proxmox node where the cluster will be deployed"
    type = string
}

variable "proxmox_api_url" {
    description = "The URL for the Proxmox API."
    type = string
}

# Setting these here so it can be used in root module .tfvars files.
# First set is passed down to Talos module.
variable "ceph_mon_disk_storage_pool" {}
variable "proxmox_debug" {}