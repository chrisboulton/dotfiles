#!/bin/bash
set -ex
target=$HOME
source="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
change_login_shell=true

if [ -f "/etc/os-release" ]; then
    . /etc/os-release
    case "$ID" in
        omarchy)
            sudo pacman -S --needed --noconfirm zsh stow
            change_login_shell=false
            ;;
        ubuntu|debian)
            sudo apt install -y zsh stow
            ;;
        *)
            echo "Unsupported Linux distribution: $ID" >&2
            exit 1
            ;;
    esac

    if ! command -v starship >/dev/null 2>&1; then
      echo "Installing starship..."
      curl -sS https://starship.rs/install.sh | sh
    fi

    if [ ! -d "$target/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        # Keep shell switching under this script's control.
        CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    if [ "$change_login_shell" = false ]; then
        echo "Keeping the current login shell on Omarchy."
    elif [ "$SHELL" != "$(command -v zsh)" ]; then
        echo "Changing shell to zsh..."
        chsh -s "$(command -v zsh)"
    fi
fi

mkdir -p "$target/.ssh" "$target/.config" "$target/.agents" "$target/.cache/zsh"

stow -d $source -t $target --ignore=setup.sh -v .

if [ -d "$source/../dotfiles-private" ]; then
    stow -d $source/../dotfiles-private -t $target -v .
fi

# configure zsh to use XDG layout
ln -fs "$source/.config/zsh/.zshenv" "$target/.zshenv"

chmod 0700 $target/.ssh
chmod 0600 $target/.ssh/id*
chmod 0600 $target/.ssh/config*
chmod 0644 $target/.ssh/*.pub
