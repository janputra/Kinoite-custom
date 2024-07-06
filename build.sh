#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
# Universal Blue specific Initramfs fixes
echo "options nvidia NVreg_EnableGpuFirmware=0" >> /usr/lib/modprobe.d/nvidia-atomic.conf
sed -i 's@omit_drivers@force_drivers@g' /usr/lib/dracut/dracut.conf.d/99-nvidia.conf

if [ ! -f /usr/libexec/rpm-ostree/wrapped/dracut ]; then
    rpm-ostree cliwrap install-to-root /
fi

if [[ "${KERNEL_FLAVOR}" == "surface" ]]; then
    KERNEL_SUFFIX="surface"
else
    KERNEL_SUFFIX=""
fi


QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

/usr/libexec/rpm-ostree/wrapped/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
# this installs a package from fedora repos
rpm-ostree install screen virt-manager samba fcitx5 fcitx5-hangul
rpm-ostree install steam mangohud gamemode 
rpm-ostree install plasma-workspace-x11 btop neovim

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
