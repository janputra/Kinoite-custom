#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
# this installs a package from fedora repos
# Universal Blue specific Initramfs fixes
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
rpm-ostree install screen virt-manager samba fcitx5 fcitx5-hangul code
rpm-ostree install steam mangohud gamemode 
rpm-ostree install plasma-workspace-x11 btop neovim fastfetch
rpm-ostree install tuned-utils tuned-gtk tuned-profiles-atomic tuned-profiles-cpu-partitioning 

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
