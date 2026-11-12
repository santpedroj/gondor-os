# Gondor OS scripts
#xargs -a: reads arguments from a specified file and passes them to the given command.

# Install my personal homebrew packages
gondor-install-brews:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Homebrews..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/santpedroj/gondor-os/main/repo_files/brews) brew install
    echo "Homebrews installation complete."

# Install my personal flatpaks
gondor-install-flatpaks:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Flatpaks..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/santpedroj/gondor-os/main/repo_files/flatpaks) flatpak --system -y install
    echo "Flatpaks installation complete."

# Install non-free fonts
# brew tap colindean/fonts-nonfree && brew install --cask font-microsoft-office font-microsoft-aptos font-arial font-arial-black font-courier-new font-times-new-roman font-georgia
gondor-install-ms-fonts:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing MS Fonts..."

    brew tap colindean/fonts-nonfree
    brew install \
        font-microsoft-office \
        font-microsoft-aptos \
        font-arial \
        font-arial-black \
        font-courier-new \
        font-times-new-roman \
        font-georgia

    echo "MS Fonts installation complete."

gondor-install-papirus-icon:
  #!/usr/bin/env bash
  set -euo pipefail

  echo "Installing Papirus Icon Theme..."
 
  wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh 
  wget -qO- https://git.io/papirus-folders-install | env PREFIX=$HOME/.local sh

  echo "Papirus Icon Theme installation complete."
