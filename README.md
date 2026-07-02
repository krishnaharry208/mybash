# ⚡ Ultimate Bash Workspace Customizer

A lightweight, automated Bash workflow utility that transforms a stock Linux/macOS terminal into a high-productivity workspace powered by **Starship prompt**, **Fastfetch**, and custom power aliases.

[![Bash Shell](https://img.shields.io/badge/shell-bash-4eaa25.svg?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Starship](https://img.shields.io/badge/prompt-starship-red.svg?logo=starship&logoColor=white)](https://starship.rs/)
[![Fastfetch](https://img.shields.io/badge/fetch-fastfetch-blue.svg)](https://github.com/fastfetch-cli/fastfetch)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## ✨ Features

* **📦 Zero-Dependency Setup** — Creates an isolated installation directory and handles environment linking cleanly.
* **🚀 Intelligent Installer** — Auto-detects package managers (`apt`, `pacman`, `dnf`, `brew`) to deploy dependencies effortlessly.
* **🛡️ Fail-Safe Backups** — Generates a timestamped backup of your existing `~/.bashrc` before applying modifications.
* **⌨️ Power Aliases** — Curated shortcuts for aggressive Git workflows, file manipulation, and fast navigation.
* **📖 Built-in Help** — A perfectly aligned, minimal in-terminal help menu to view shortcuts on the fly.

---

## 🛠️ Tech Stack & Components

| Component | Description | Role |
| :--- | :--- | :--- |
| **Starship** | Cross-shell prompt written in Rust | Provides speed, git status tracking, and minimal design. |
| **Fastfetch** | High-performance system information tool | Displays system hardware and distro info cleanly on shell startup. |
| **Custom Aliases** | Native Bash functions & shortcuts | Maximizes command-line efficiency and system management. |

---

## 🚀 Quick Start & Installation

Clone the repository and run the automated installation script:

```bash
# Make the utility script executable
chmod +x mybash.sh

# Run the deployment and package setup
./mybash.sh