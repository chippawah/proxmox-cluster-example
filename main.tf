# Handles creating the VMs in Proxmox for a Talos Cluster.
# Does NOT bootstrap the cluster.
module "talos" {
    source = "./talos"
    proxmox_host_node = "r720"
    proxmox_api_url = "https://10.1.0.5:8006/api2/json"
    worker_node_count = 4
}