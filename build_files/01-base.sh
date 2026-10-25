#!/bin/bash
set -ouex pipefail

# Terra packages
# Install Ghostty's matching KIO integration while Terra is available; the KDE
# portal pulls in kf6-kio-core, which makes ghostty-kio a required dependency.
dnf5 install -y --from-repo=terra --setopt=terra.excludepkgs=noctalia \
  zed \
  ghostty \
  ghostty-kio \
  satty

# apps
dnf5 install -y \
  brave-origin

# file manager
dnf5 install -y \
  ark \
  dolphin

# functionality
dnf5 install -y \
  kanshi \
  gnome-keyring \
  gnome-keyring-pam

# screenshot
dnf5 install -y \
  grim \
  slurp

# cli
dnf5 install -y \
  git \
  neovim \
  tmux \
  zsh

echo "Adding Gondor OS just recipes"
echo "import \"/usr/share/gondor-os/just/gondor.just\"" >>/usr/share/ublue-os/just/60-custom.just
