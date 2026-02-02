# 📦 Universal Distrobox Installer

**The "Double-Click" installer for Bazzite and Steam Deck.**

Easily install `.deb` and `.rpm` files on immutable Linux systems (like Bazzite, SteamOS, or Silverblue) without touching the terminal.

## 🧐 Why use this?
On immutable systems like **Bazzite** or **SteamOS**, it is not recommended to install packages to the system layer. The recommended solution is [Distrobox](https://distrobox.it/), but that requires using the command line for every install.

**This tool automates the process.** It creates a "Wizard" that allows you to double-click a package file, automatically spins up the correct container, installs the app, and exports it to Start Menu.

## ✨ Features
* **Minimal Setup:** Automatically creates the necessary containers (`deb-installer` or `rpm-installer`) if they don't exist.
* **Multi-Distro Support:**
    * Supports **Debian/Ubuntu** packages (`.deb`)
    * Supports **Fedora/Red Hat** packages (`.rpm`)
* **Desktop Integration:** Exports the app icon to your system menu immediately.
* **Instant Launch:** Prompt to launch the application immediately after installation.

## 🚀 Installation
*We assume you have already installed [Distrobox](https://distrobox.it/). I also use [DistroShelf](https://github.com/ranfdev/DistroShelf), which comes with Bazzite.*
1.  **Clone or Download** this repository.
2.  Open a terminal in the folder.
3.  Run the deployment script:
    ```bash
    chmod +x deploy.sh
    ./deploy.sh
    ```

This will copy the scripts to `~/.local/bin/` and register the desktop handler in `~/.local/share/applications/`.

## 🖱️ Usage

1.  Download any `.deb` or `.rpm` file (e.g., Discord, VS Code, Kenku FM).
2.  **Right-Click** the file and select **Properties**.
3.  Go to **"Open With"**.
4.  Select **"Install with Distrobox Wizard"** and set it as Default.

From now on, just **double-click** any package to install it!

## 🔮 Roadmap & Requests
Currently, this tool uses **Debian** images for `.deb` files and **Fedora** images for `.rpm` files.

I plan to add support for other distributions and package types in the future (e.g., Arch/AUR support).

**Have a request?**
I would gladly hear your feedback! If you have a specific distro you want supported or a feature request, please [open an issue](issues) on this repository.