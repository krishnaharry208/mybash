# ⚡ Ultimate Bash Workspace Customizer

A lightweight, automated Bash workflow utility that transforms a stock Linux/macOS terminal into a high-productivity workspace using **Starship prompt**, **Fastfetch**, and custom powerhouse aliases. 

[![Bash Shell](https://img.shields.io/badge/shell-bash-4eaa25.svg?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Starship](https://img.shields.io/badge/prompt-starship-red.svg?logo=starship&logoColor=white)](https://starship.rs/)
[![Fastfetch](https://img.shields.io/badge/fetch-fastfetch-blue.svg)](https://github.com/fastfetch-cli/fastfetch)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## ✨ Features

* **📦 Zero-Dependency Setup:** Creates its own isolated installation folder and manages dependencies automatically.
* **🚀 Automated Installer:** Detects your package manager (`apt`, `pacman`, `dnf`, or `Homebrew`) to download and configure **Fastfetch** and **Starship Prompt** on the fly.
* **🛡️ Safety First:** Automatically takes a timestamped backup of your existing `.bashrc` before making any structural changes.
* **⌨️ Power Aliases:** Includes curated shortcuts for Git operations, structural file manipulation, process killing, and dynamic navigation.
* **📖 Built-in Documentation:** An intuitive, perfectly vertical help menu available natively inside the terminal session.

---

## 🚀 Quick Start & Installation

To deploy this environment to your machine, clone your repository or drop the `mybash.sh` script onto your local system, then execute the following commands:

```bash
# Make the script executable
chmod +x mybash.sh

# Run the installer script
./mybash.sh
