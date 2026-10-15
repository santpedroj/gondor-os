#!/usr/bin/env bash
set -euo pipefail

# Remove inherited KDE Framework 5 libraries after installing the desktop.
dnf5 remove -y 'kf5-*' || true

# Remove packages no longer required by the installed desktop.
dnf5 autoremove -y || true

# Fail the build if package dependencies are inconsistent.
dnf5 check
