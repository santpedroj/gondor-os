#!/usr/bin/env bash
set -euo pipefail

# Reuse Bazzite's Terra repo for these desktop packages.
dnf5 install -y --from-repo=terra --setopt=terra.excludepkgs=noctalia \
  noctalia-greeter \
  nwg-look \
  umbriel-nightly

dnf5 install -y greetd

# niri
dnf5 install -y \
  niri \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome
#xdg-desktop-portal-kde

# Install/update Noctalia exclusively from Fedora.
dnf5 install -y --refresh \
  --from-repo=fedora,updates \
  noctalia

# theming
dnf5 install -y \
  adw-gtk3-theme \
  qt6ct

# Build-time RPM state is replaced by the system_files configuration afterward.
rm -rf /var/lib/greetd/.config
