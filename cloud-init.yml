#cloud-config

# Create a non-root admin user
users:
  - name: adminuser
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8HwuHAPUxxLCKrnIaoUbZr3blSgrLp3E4rEipwgDVu7UUThivIURwyBNnoDr7M+6en0gMqhu01jVs8pwBwjtspRkCfmb7O33VQDMoU9PUVndRHVIP9KCa5T1Gki3hmipJ2qG79dZSsY8NFuk3V2eyR4WWX+D2x03XM65UmWpFr/vGY9ABUr3Z0fd5P8GXh1z/V+nCKswijmsh+baS5lwV+1i3YDo6z7eZwURzvYA4Pc2oOGSSWtw12USs09h+ngT9CqjCE3OiAXjft2IGtR0itBbRl0KEEPSEVB6VCYc5/EXJuCwn0qRupKTW00ivctAuoVV8tis3cTy5DbBOx/GGFY6W0QuQAk3XV5jnQAEnKe8u9pOlkBZhKaxrAYEzVWVRyl+DtILezj2wem6Su03oU5zNWa3ZinK1EEWpbHhl1WxgCOvu/SY6LijxULndggyHk9/8LaA1PFNeruD9/RHaKrCdW3ZMRw+sPE/S2QJ6mIik+DChiHaxHDDfbmW+v02sBpAanPkDSjr4wiXltHAB3cMmCUHRoOXd+19eYXU0Lzl+tu/4eO/3gqTWnnZixBOPmZG4meXzkLIz9fNPGpbcstngtfe6mxaBBFgwxeALU8Z2qFHcmxOvWjWaSbaD4vG7Jzl4bW++bxvURJzg6pwjYINnW4u4jqGKZw44LVuxZQ== carlhayes@Carls-MacBook-Pro.local
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
  - ufw allow 22/tcp
  - ufw allow 80/tcp
  - ufw allow 443/tcp
  - ufw --force enable

  # Enable automatic security updates
  - dpkg-reconfigure -f noninteractive unattended-upgrades