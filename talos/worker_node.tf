resource "proxmox_vm_qemu" "talos-worker-node" {
    count = var.worker_node_count
    name = "talos-worker-${count.index}"
    iso = var.iso_image_location
    target_node = var.proxmox_host_node
    vmid = sum([900, count.index, var.control_plane_node_count])
    qemu_os = "l26" # Linux kernel type
    scsihw = "virtio-scsi-pci"
    memory = var.worker_node_memory
    cpu = "kvm64"
    cores = 4
    sockets = 1
    network {
        model = "virtio"
        tag = var.config_vlan
        bridge = var.config_network_bridge
    }
    network {
        model = "virtio"
        tag = var.public_vlan
        bridge = var.public_network_bridge
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
    disk {
        type = "virtio"
        size = var.ceph_osd_disk_size
        storage = var.ceph_osd_disk_storage_pool
    }
}