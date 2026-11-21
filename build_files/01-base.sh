#!/bin/bash
set -ouex pipefail

# =============================================================================
# OS-RELEASE BRANDING
# =============================================================================
# Customize os-release for Gondor branding (shown in GRUB via PRETTY_NAME)

VERSION_ID=$(grep "^VERSION_ID=" /usr/lib/os-release | cut -d'=' -f2)
OSTREE_VERSION="${VERSION_ID}.$(TZ=America/New_York date +%Y%m%d).0"
sed -i "s/^OSTREE_VERSION=.*/OSTREE_VERSION='${OSTREE_VERSION}'/" /usr/lib/os-release

sed -i 's/^NAME=.*/NAME="Gondor"/' /usr/lib/os-release
sed -i "s/^PRETTY_NAME=.*/PRETTY_NAME=\"Gondor (Version: ${OSTREE_VERSION})\"/" /usr/lib/os-release
sed -i "s/^BOOTLOADER_NAME=.*/BOOTLOADER_NAME=\"Gondor (${OSTREE_VERSION})\"/" /usr/lib/os-release
sed -i 's/^DEFAULT_HOSTNAME=.*/DEFAULT_HOSTNAME="gondor"/' /usr/lib/os-release
sed -i 's|^HOME_URL=.*|HOME_URL="https://github.com/santpedroj/gondor-os"|' /usr/lib/os-release
sed -i 's|^DOCUMENTATION_URL=.*|DOCUMENTATION_URL="https://github.com/santpedroj/gondor-os"|' /usr/lib/os-release
sed -i 's|^SUPPORT_URL=.*|SUPPORT_URL="https://github.com/santpedroj/gondor-os/issues"|' /usr/lib/os-release
sed -i 's|^BUG_REPORT_URL=.*|BUG_REPORT_URL="https://github.com/santpedroj/gondor-os/issues"|' /usr/lib/os-release

# Additional branding fixes for distro command output
sed -i 's/^ID=.*/ID=gondor/' /usr/lib/os-release
sed -i "s/^VERSION=.*/VERSION=\"${VERSION_ID} (Osgiliath)\"/" /usr/lib/os-release
sed -i 's/^VERSION_CODENAME=.*/VERSION_CODENAME="Osgiliath"/' /usr/lib/os-release
sed -i 's/^LOGO=.*/LOGO=gondor/' /usr/lib/os-release
sed -i 's/^VARIANT=.*/VARIANT="Umbriel"/' /usr/lib/os-release
sed -i 's/^VARIANT_ID=bazzite/VARIANT_ID=gondor/' /usr/lib/os-release
sed -i 's|^CPE_NAME=.*|CPE_NAME=cpe:/o:santpedroj:gondor-os:'"${VERSION_ID}"'|' /usr/lib/os-release
sed -i 's/^IMAGE_ID=bazzite/IMAGE_ID=gondor/' /usr/lib/os-release

# =============================================================================
# Gondor BRANDING (MOTD & FASTFETCH)
# =============================================================================
# Override Bazzite's MOTD and fastfetch with Gondor branding

# Install Gondor branding files for fastfetch
mkdir -p /usr/share/ublue-os/gondor
cp /ctx/build/gondor/logo.txt /usr/share/ublue-os/gondor/
cp /ctx/build/gondor/fastfetch.jsonc /usr/share/ublue-os/gondor/

# Override Bazzite's fastfetch aliases with Gondor config
# Using 'zzz-' prefix ensures this runs after bazzite-neofetch.sh
cp /ctx/build/gondor/gondor-fastfetch.sh /etc/profile.d/zzz-gondor-fastfetch.sh

# Replace Bazzite MOTD with Gondor MOTD
cp /ctx/build/gondor/motd.md /usr/share/ublue-os/motd/gondor.md
# Remove Bazzite-specific MOTD if it exists
rm -f /usr/share/ublue-os/motd/bazzite.md

# Fix ublue-motd script to use gondor.md instead of bazzite.md
sed -i 's|/usr/share/ublue-os/motd/bazzite.md|/usr/share/ublue-os/motd/gondor.md|g' /usr/libexec/ublue-motd

# Update image-info.json with Gondor branding
if [[ -f /usr/share/ublue-os/image-info.json ]]; then
  jq '.["image-name"] = (.["image-name"] | gsub("bazzite"; "gondor-os")) | .["image-vendor"] = "santpedroj"' \
    /usr/share/ublue-os/image-info.json >/tmp/image-info.json
  mv /tmp/image-info.json /usr/share/ublue-os/image-info.json
fi

# Replace MOTD tips with Gondor-specific tips
rm -f /usr/share/ublue-os/motd/tips/10-ublue.md
rm -f /usr/share/ublue-os/motd/tips/20-bazzite.md
cp /ctx/build/gondor/tips.md /usr/share/ublue-os/motd/tips/10-gondor.md

# =============================================================================
# PACKAGES
# =============================================================================

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
  nautilus \
  file-roller-nautilus \
  file-roller
#nemo
#thunar \
#thunar-archive-plugin \
#thunar-volman \

# functionality
dnf5 install -y \
  kanshi \
  gnome-keyring \
  gnome-keyring-pam \
  udisks2 \
  gvfs \
  glycin-thumbnailer

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
