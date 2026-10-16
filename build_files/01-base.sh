#!/bin/bash
set -ouex pipefail

# Terra is already included in the Bazzite base; no additional repository is needed.

# apps
dnf5 install -y \
  brave-origin \
  thunar \
  thunar-archive-plugin \
  thunar-volman \
  zed

# functionality
dnf5 install -y \
  file-roller \
  kanshi \
  gnome-keyring \
  gnome-keyring-pam

# screenshot
dnf5 install -y \
  grim \
  slurp \
  satty

# cli
dnf5 install -y \
  git \
  ghostty \
  neovim \
  tmux \
  zsh

echo "Adding Sant OS just recipes"
echo "import \"/usr/share/sant-os/just/sant.just\"" >>/usr/share/ublue-os/just/60-custom.just
