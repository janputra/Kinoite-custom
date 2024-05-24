#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
# this installs a package from fedora repos
rpm-ostree install screen virt-manager samba fcitx5 fcitx5-hangul

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl disable tailscaled.service
systemctl disable brew-dir-fix.service 
systemctl disable brew-setup.service 
systemctl disable brew-upgrade.timer
systemctl disable brew-update.timer 
## remove packages
rpm-ostree override remove cockpit-networkmanager cockpit-podman cockpit-selinux cockpit-system cockpit-navigator cockpit-storaged
rpm-ostree override remove lutris obs-vkcapture.x86_64 obs-vkcapture.i686 cage wlr-randr
rpm-ostree override remove fluidsynth fluid-soundfont-gm qsynth wxGTK libFAudio wine-core.x86_64 wine-core.i686 wine-pulseaudio.x86_64 wine-pulseaudio.i686 winetricks protontricks
rpm-ostree override remove tailscale fish xdotool webapp-manager wmctrl steamdeck-kde-presets-desktop   
rm -R /home/linuxbrew/.linuxbrew
rm /usr/share/applications/winetricks.desktop 