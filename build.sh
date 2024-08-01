#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
# this installs a package from fedora repos
# Universal Blue specific Initramfs fixes

rpm-ostree install screen virt-manager samba fcitx5 fcitx5-hangul
rpm-ostree install steam mangohud gamemode 
rpm-ostree install plasma-workspace-x11 btop neovim fastfetch
rpm-ostree uninstall firefox
# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
