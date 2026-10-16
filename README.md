# Gondor OS

A personal Linux desktop image built on Bazzite NVIDIA Open, with Niri, Noctalia, and a curated selection of everyday and development tools.

Gondor OS replaces the inherited KDE Plasma desktop with a Wayland environment centered on Niri. Desktop packages, system services, and login defaults are defined in this repository and built into a bootc image.

## Image overview

| Component | Configuration |
| --- | --- |
| Base image | `ghcr.io/ublue-os/bazzite-nvidia-open:stable` |
| Gondor OS image | `ghcr.io/santpedroj/gondor-os:latest` |
| Wayland compositor | Niri |
| Desktop shell | Noctalia, sourced from Fedora repositories |
| Login manager | Noctalia Greeter, sourced from Terra and launched by greetd |
| System delivery | bootc container image published to GitHub Container Registry |

The image follows Bazzite's `stable` NVIDIA Open base and publishes Gondor OS builds under the `latest` tag. Hardware compatibility depends on the NVIDIA Open base image.

## Included software

Gondor OS adds the following applications and tools to its base:

| Purpose | Software |
| --- | --- |
| Web browser | Brave Origin |
| File management | Thunar, Thunar Archive Plugin, Thunar Volume Manager, File Roller |
| Terminal and editors | Ghostty, Zed, Neovim |
| Command line | Git, tmux, Zsh |
| Screenshots and annotation | grim, slurp, Satty |
| Display configuration | kanshi |
| Appearance | adw-gtk3, nwg-look, qt6ct |
| Credential storage | GNOME Keyring |

The build removes inherited Plasma components, selected KDE applications, Lutris, Waydroid, and handheld-specific packages. Podman's socket is enabled for container tooling.

## Switch to Gondor OS

From an existing compatible bootc installation, stage the Gondor OS image:

```bash
sudo bootc switch ghcr.io/santpedroj/gondor-os:latest
sudo reboot
```

After rebooting, inspect the active deployment:

```bash
sudo bootc status
```

## Optional application collections

Gondor OS includes two commands for installing the personal package collections maintained in this repository. These collections are installed separately from the system image.

```bash
ujust gondor-install-flatpaks
ujust gondor-install-brews
```

The [Flatpak collection](repo_files/flatpaks) includes OBS Studio, ONLYOFFICE, Podman Desktop, Prism Launcher, Flatseal, and other desktop applications. The [Homebrew collection](repo_files/brews) includes tools such as Atuin, bat, btop, fzf, lazygit, ripgrep, uv, Yazi, and Zoxide.

These commands fetch the current package lists from this repository's `main` branch. The Homebrew command requires a working Homebrew installation.

## Login configuration

Noctalia Greeter is the default login screen. The shipped configuration selects the Niri session, preselects the `pedro` account, and uses the US AltGr international keyboard layout. The account selection is a personal default; it does not create a user account.

To adapt the login screen on an installed system, edit `/etc/noctalia-greeter/greeter.toml`. To change the defaults built into future images, edit [the repository configuration](system_files/etc/noctalia-greeter/greeter.toml).

See [Noctalia Greeter configuration and use](docs/noctalia-greeter.md) for configuration details, migration from the previous login manager, and troubleshooting.

## Build locally

With Podman, just, and jq installed, build the image from the repository root:

```bash
just build
```

This produces `gondor-os:latest` in local container storage. The [Containerfile](Containerfile) defines the base image and build sequence; [build_files](build_files) contains package and service customization scripts, and [system_files](system_files) contains the files applied to the image.

The container workflow is configured to build daily at 10:05 UTC, on qualifying pushes to `main`, and on manual runs. Pull requests build for validation. Publishing and signing are restricted to runs on the repository's default branch outside pull requests.

The image is published as `ghcr.io/santpedroj/gondor-os`. Its source links follow the GitHub repository independently of the image name.

## License

Repository code is licensed under [Apache License 2.0](LICENSE). Included software retains its respective licenses.
