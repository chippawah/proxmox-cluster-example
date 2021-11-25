terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = ">=2.9.1"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = var.proxmox_tls_insecure
    pm_api_url = var.proxmox_api_url
    pm_api_token_secret = var.proxmox_api_token_secret
    pm_api_token_id = var.proxmox_api_token_id
    pm_debug = var.proxmox_debug
}
