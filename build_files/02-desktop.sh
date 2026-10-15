#!/usr/bin/env bash
set -euo pipefail

# niri
dnf5 install -y \
  niri \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome

# Use Fedora's Noctalia shell; keep Terra available for other packages.
# Synchronize an inherited package too: install alone keeps it if already present.
if rpm -q noctalia >/dev/null 2>&1; then
  dnf5 distro-sync -y --refresh --from-repo=fedora,updates noctalia
else
  dnf5 install -y --refresh --from-repo=fedora,updates noctalia
fi

# theming
dnf5 install -y \
  adw-gtk3-theme \
  nwg-look \
  qt6ct

# Select the stable Terra package; dependencies can use the other base repos.
dnf5 install -y --from-repo=terra noctalia-greeter
dnf5 install -y greetd

# Build-time RPM state is replaced by the system_files configuration afterward.
rm -rf /var/lib/greetd/.config
