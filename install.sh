#!/bin/bash
#[[
# File: install.sh
# Description: One-click installer for the lightweight custom Neovim configuration.
# Design: Supports macOS (via homebrew) and Linux (via package managers + direct binary download).
#]]

set -e

OS=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to detect the operating system
check_os() {
    local uname_out
    uname_out="$(uname -s)"
    case "${uname_out}" in
        Linux*)  OS="linux";;
        Darwin*) OS="mac";;
        *)       echo "Unsupported OS: ${uname_out}" && exit 1;;
    esac
    echo "Detected operating system: ${OS}"
}

# Function to backup existing configurations
backup_old_config() {
    local backup_suffix
    backup_suffix=$(date +%Y%m%d%H%M%S)
    local dirs=("~/.config/nvim" "~/.local/share/nvim" "~/.local/state/nvim" "~/.cache/nvim")
    
    echo "Backing up old Neovim paths..."
    for dir in "${dirs[@]}"; do
        # Evaluate directory path
        local eval_dir
        eval_dir=$(eval echo "${dir}")
        if [ -e "${eval_dir}" ] || [ -L "${eval_dir}" ]; then
            echo "Backing up ${eval_dir} to ${eval_dir}.backup.${backup_suffix}"
            mv "${eval_dir}" "${eval_dir}.backup.${backup_suffix}"
        fi
    done
}

# Function to install dependencies on macOS using Homebrew
install_mac_deps() {
    echo "Installing/upgrading dependencies on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Please install it first: https://brew.sh/"
        exit 1
    fi
    brew install neovim git ripgrep fd make unzip tree-sitter
}

# Function to install Neovim on Linux manually from Github release (binary format)
install_neovim_linux() {
    echo "Installing Neovim pre-built binary on Linux..."
    local dest_dir="$HOME/.local"
    mkdir -p "${dest_dir}"
    
    # Download the pre-built tarball from official GitHub release (locked to v0.12.4)
    local nvim_url="https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.tar.gz"
    curl -LO "${nvim_url}"
    
    # Extract and install to ~/.local
    tar -xzf nvim-linux-x86_64.tar.gz -C "${dest_dir}" --strip-components=1
    rm nvim-linux-x86_64.tar.gz
    
    # Inform user to export PATH if ~/.local/bin is not in PATH
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo "Please add \$HOME/.local/bin to your PATH in your shell configuration (.zshrc or .bashrc)."
        echo "e.g., export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
}

# Helper function to run commands with sudo if necessary, available, and not root
run_cmd() {
    if [ "$(id -u)" -ne 0 ] && command -v sudo &> /dev/null; then
        sudo "$@"
    else
        "$@"
    fi
}

# Function to install dependencies on Linux using pacman, apt or dnf
install_linux_deps() {
    echo "Installing dependencies on Linux..."
    if command -v apt-get &> /dev/null; then
        run_cmd apt-get update
        run_cmd apt-get install -y git make unzip curl tar
        run_cmd apt-get install -y ripgrep fd-find || echo "Note: ripgrep or fd-find not found. Please install them manually."
    elif command -v pacman &> /dev/null; then
        run_cmd pacman -Syu --noconfirm git make unzip curl tar
        run_cmd pacman -S --noconfirm ripgrep fd || echo "Note: ripgrep or fd not found. Please install them manually."
    elif command -v dnf &> /dev/null; then
        run_cmd dnf install -y git make unzip curl tar
        run_cmd dnf install -y ripgrep fd-find || echo "Note: ripgrep or fd-find not found. Please install them manually."
    else
        echo "Unsupported Linux package manager. Please install git, ripgrep, fd, make, unzip, curl, tar manually."
    fi

    # Install Neovim binary directly to avoid outdated versions from standard repos
    install_neovim_linux
}

# Function to link or clone config files
setup_config_symlink() {
    local target_config="$HOME/.config/nvim"
    mkdir -p "$HOME/.config"
    
    if [ -f "${SCRIPT_DIR}/init.lua" ]; then
        echo "Linking local repository directory to ~/.config/nvim..."
        ln -sf "${SCRIPT_DIR}" "${target_config}"
    else
        echo "Cloning lightweight config into ~/.config/nvim..."
        # Clones the configured remote repository
        git clone https://github.com/ujoyli/nvconfig.git "${target_config}"
    fi
}

# Main execution flow
main() {
    check_os
    backup_old_config
    
    if [ "${OS}" = "mac" ]; then
        install_mac_deps
    else
        install_linux_deps
    fi
    
    setup_config_symlink
    echo "Installation and configuration completed! Launch Neovim by typing: nvim"
}

main
