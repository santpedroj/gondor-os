#!/bin/bash
set -ouex pipefail

# Terra packages
dnf5 install -y --from-repo=terra --setopt=terra.excludepkgs=noctalia \
  zed \
  satty

# apps
dnf5 install -y \
  brave-origin \
  kitty

# file manager
dnf5 install -y \
  thunar \
  thunar-archive-plugin \
  thunar-volman \
  file-roller

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
