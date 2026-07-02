#!/bin/bash

# Define paths
INSTALL_DIR="$HOME/bash_setup_downloads"
BASHRC="$HOME/.bashrc"
BASHRC_BACKUP="$HOME/.bashrc.bak.$(date +%F_%T)"
STARSHIP_DIR="$HOME/.config"
STARSHIP_TOML="$STARSHIP_DIR/starship.toml"
STARSHIP_BACKUP="$STARSHIP_DIR/starship.toml.bak.$(date +%F_%T)"

# 1. Automatically create directories
echo "📁 Creating configuration and setup folders..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$STARSHIP_DIR" # Ensures ~/.config folder is automatically created
cd "$INSTALL_DIR" || exit

echo "🔄 Checking for required dependencies..."

# Function to automatically install packages based on system package manager
install_package() {
    local pkg=$1
    if command -v "$pkg" >/dev/null 2>&1; then
        echo "✅ $pkg is already installed."
    else
        echo "📥 $pkg not found. Attempting automatic installation..."
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y "$pkg"
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Syu --noconfirm "$pkg"
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y "$pkg"
        elif command -v brew >/dev/null 2>&1; then
            brew install "$pkg"
        else
            echo "❌ Could not find a supported package manager (apt, pacman, dnf, brew)."
            echo "⚠️  Please install $pkg manually, then re-run this script."
        fi
    fi
}

# Install Fastfetch
install_package "fastfetch"

# Install Starship
if command -v starship >/dev/null 2>&1; then
    echo "✅ Starship is already installed."
else
    echo "📥 Installing Starship prompt..."
    if command -v curl >/dev/null 2>&1; then
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
    else
        echo "❌ 'curl' is required to fetch Starship. Please install curl first."
    fi
fi

# 2. Back up existing configs safely
if [ -f "$BASHRC" ]; then
    echo "📦 Backing up your current .bashrc to $BASHRC_BACKUP"
    cp "$BASHRC" "$BASHRC_BACKUP"
fi

if [ -f "$STARSHIP_TOML" ]; then
    echo "📦 Backing up your current starship.toml to $STARSHIP_BACKUP"
    cp "$STARSHIP_TOML" "$STARSHIP_BACKUP"
fi

# 3. Create and add your custom configuration directly to ~/.config/starship.toml
echo "🎨 Writing your custom Starship theme to $STARSHIP_TOML..."
cat << 'EOF' > "$STARSHIP_TOML"
format = """
[](#2E3440)\
$os\
$username\
[](bg:#3B4252 fg:#2E3440)\
$directory\
[](fg:#3B4252 bg:#434C5E)\
$git_branch\
$git_status\
[](fg:#434C5E bg:#4C566A)\
$c\
$elixir\
$elm\
$golang\
$gradle\
$haskell\
$java\
$julia\
$nodejs\
$nim\
$rust\
$scala\
[](fg:#4C566A bg:#5E81AC)\
$docker_context\
[](fg:#5E81AC bg:#81A1C1)\
$time\
[ ](fg:#81A1C1)\
"""

add_newline = false

[username]
show_always = true
style_user = "bg:#2E3440 fg:#D8DEE9"
style_root = "bg:#2E3440 fg:#BF616A"
format = '[$user ]($style)'
disabled = false

[os]
style = "bg:#2E3440 fg:#D8DEE9"
disabled = true 

[directory]
style = "bg:#3B4252 fg:#E5E9F0"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[git_branch]
symbol = ""
style = "bg:#434C5E fg:#88C0D0"
format = '[ $symbol $branch ]($style)'

[git_status]
style = "bg:#434C5E fg:#EBCB8B"
format = '[$all_status$ahead_behind ]($style)'

[c]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[elixir]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[elm]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[golang]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[gradle]
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[haskell]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[java]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[julia]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[nodejs]
symbol = ""
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[nim]
symbol = "󰆥 "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[rust]
symbol = ""
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[scala]
symbol = " "
style = "bg:#4C566A fg:#E5E9F0"
format = '[ $symbol ($version) ]($style)'

[docker_context]
symbol = " "
style = "bg:#5E81AC fg:#ECEFF4"
format = '[ $symbol $context ]($style)'

[time]
disabled = false
time_format = "%R" 
style = "bg:#81A1C1 fg:#2E3440"
format = '[ 󱎫 $time ]($style)'
EOF

# 4. Write the final configuration to .bashrc
echo "📝 Writing configurations to .bashrc..."
cat << 'EOF' > "$BASHRC"
# ==========================
# ✨ Shell & Prompt Initialization
# ==========================

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

# ==========================
# 🛠️ Aliases
# ==========================
alias ll='ls -lah'
alias la='ls -A'
alias l='ls'
alias grep='grep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias .bash='nano ~/.bashrc'
alias src='source ~/.bashrc'
alias c='clear'
alias hist='history'
alias h='history | grep'
alias shh='show-help'

command -v bat >/dev/null 2>&1 && alias cat='bat'
command -v btop >/dev/null 2>&1 && alias top='btop'

# ==========================
# 🐙 Git Aliases & Functions
# ==========================
alias gs='git status'
alias ga='git add .'
alias gp='git push'
alias gpull='git pull'

gcl() { git clone "$@"; }
gcom() { git add .; git commit -m "$*"; }
gcmt() { git commit -m "$*"; }
lazyg() { git add .; git commit -m "$*"; git push; }

# ==========================
# 📂 Quick Navigation
# ==========================
docs() { cd "$HOME/Documents" || return; }
down() { cd "$HOME/Downloads" || return; }

# ==========================
# 🧰 File Utilities
# ==========================
mkcd() { mkdir -p "$1" && cd "$1" || return; }
ff() { find . -type f -iname "*$1*"; }
touchfile() { touch "$1"; }
head10() { head -n 10 "$1"; }
whichcmd() { command -v "$1"; }
replace() { sed -i "s/$2/$3/g" "$1"; }

trash() {
    if command -v gio >/dev/null 2>&1; then
        gio trash "$@"
    else
        rm -rf "$@"
    fi
}

# ==========================
# ⚙️ Process & System Utilities
# ==========================
pg() { pgrep -a "$1"; }
pk() { pkill -f "$1"; }
k9() { pkill -9 -f "$1"; }
uptimeinfo() { uptime -p; }

html() {
    if [ -z "$1" ]; then
        echo "Usage: html <project-name>"
        return 1
    fi
    mkdir -p "$1" && cd "$1" || return
    touch index.html style.css script.js
    code .
}

# ==========================
# ❓ Help Menu
# ==========================
show-help() {
    echo -e "\e[1;35m═══════════════════════════════════════\e[0m"
    echo -e "\e[1;36m        ⚡ TERMINAL COMMAND HELP ⚡\e[0m"
    echo -e "\e[1;35m═══════════════════════════════════════\e[0m"

    echo -e "\n\e[1;33mALIASES\e[0m"
    echo -e "\e[1;32mll\e[0m       → list files (detailed)"
    echo -e "\e[1;32mla\e[0m       → list all files"
    echo -e "\e[1;32ml\e[0m        → list files"
    echo -e "\e[1;32m..\e[0m       → up one directory"
    echo -e "\e[1;32m...\e[0m      → up two directories"
    echo -e "\e[1;32mcat\e[0m      → view file contents"
    echo -e "\e[1;32mc\e[0m        → clear terminal screen"
    echo -e "\e[1;32mhist\e[0m     → show full command history"
    echo -e "\e[1;32mh <text>\e[0m → search through history"
    echo -e "\e[1;32msrc\e[0m      → reload configuration changes"

    echo -e "\n\e[1;33mGIT SHORTCUTS\e[0m"
    echo -e "\e[1;32mgs\e[0m          → git status"
    echo -e "\e[1;32mga\e[0m          → git add all files"
    echo -e "\e[1;32mgp\e[0m          → git push changes"
    echo -e "\e[1;32mgpull\e[0m       → git pull updates"
    echo -e "\e[1;32mgcl\e[0m         → git clone a repository"
    echo -e "\e[1;32mgcom <msg>\e[0m  → git add + git commit"
    echo -e "\e[1;32mlazyg <msg>\e[0m → git add + commit + push altogether"

    echo -e "\n\e[1;33mFILES & PROJECTS\e[0m"
    echo -e "\e[1;32mhtml <name>\e[0m           → setup HTML environment + launch Code"
    echo -e "\e[1;32mmkcd <dir_name>\e[0m       → create a folder and enter it"
    echo -e "\e[1;32mff <file_name>\e[0m        → search for files by name"
    echo -e "\e[1;32mtouchfile <file_name>\e[0m → create an empty file"
    echo -e "\e[1;32mtrash <file_name>\e[0m    → move items safely to system trash"
    echo -e "\e[1;32mreplace <f> <o> <n>\e[0m   → replace text globally inside a file"

    echo -e "\n\e[1;33mQUICK NAVIGATION\e[0m"
    echo -e "\e[1;32mdocs\e[0m → go directly to Documents folder"
    echo -e "\e[1;32mdown\e[0m → go directly to Downloads folder"
    echo -e "\e[1;32mz\e[0m    → dynamic smart-jump to locations (zoxide)"

    echo -e "\n\e[1;35m═══════════════════════════════════════\e[0m"
}

# ==========================
# 🎉 Startup Output
# ==========================
clear
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi
echo -e "\e[1;36m💡 Type 'shh' to see your custom help menu!\e[0m\n"
EOF

echo "🚀 Applying configurations dynamically..."
echo "✅ Setup complete! Folder ~/.config/ and file starship.toml have been handled perfectly."

# Refresh shell session
exec bash
