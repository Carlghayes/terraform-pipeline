#cloud-config

# Create a non-root admin user
users:
  - name: adminuser
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${ssh_public_key}
# Disable root SSH login and password authentication
write_files:
  - path: /etc/ssh/sshd_config.d/hardening.conf
    content: |
      PermitRootLogin no
      PasswordAuthentication no
      PubkeyAuthentication yes

# Install packages
packages:
  - ufw
  - unattended-upgrades

# Run commands after boot
runcmd:
  # Restart SSH to apply hardening config
  - systemctl restart sshd

  # Configure UFW firewall
  - ufw default deny incoming
  - ufw default allow outgoing
%{ for rule in ingress_rules ~}
  - ufw allow ${rule.port}/${rule.protocol}
%{ endfor ~}
  - ufw --force enable

  # Enable automatic security updates
  - dpkg-reconfigure -f noninteractive unattended-upgrades