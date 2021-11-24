resource "proxmox_vm_qemu" "talos-control-plane-node" {
    count = var.control_plane_node_count
    name = "talos-control-plane-${count.index}"
    iso = var.iso_image_location
    target_node = var.proxmox_host_node
    vmid = sum([900, count.index])
    qemu_os = "l26" # Linux kernel type
    scsihw = "virtio-scsi-pci"
    memory = var.control_plane_node_memory
    cpu = "kvm64"
    cores = 4
    sockets = 1
    network {
        model = "virtio"
        bridge = var.config_network_bridge
        tag = var.config_vlan
    }
    network {
        model = "virtio"
        bridge = var.public_network_bridge
        tag = var.public_vlan
    }
    disk {
        type = "virtio"
        size = var.boot_disk_size
        storage = var.boot_disk_storage_pool
    }
    disk {
        type = "virtio"
        size = var.ceph_mon_disk_size
        storage = var.ceph_mon_disk_storage_pool
    }
}