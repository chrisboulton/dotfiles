#!/bin/bash
set -ex
target=$HOME
source="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p $target/.ssh $target/.config $target/.agents $target/.cache/zsh

# if linux
if [ -f "/etc/os-release" ]; then
    echo "Installing dependencies for Linux..."
    sudo apt install -y zsh

    if [ ! -f /usr/local/bin/starship ]; then
      echo "Installing starship..."
      curl -sS https://starship.rs/install.sh | sh
    fi

    if [ ! -d "$target/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    echo "Changing shell to zsh..."
    chsh -s $(which zsh)
fi

stow -d $source -t $target --ignore=setup.sh -v .

if [ -d "$source/../dotfiles-private" ]; then
    stow -d $source/../dotfiles-private -t $target -v .
fi

# configure zsh to use XDG layout
ln -fs $source/.config/zsh/.zshenv $target/.zshenv

chmod 0700 $target/.ssh
chmod 0600 $target/.ssh/id*
chmod 0600 $target/.ssh/config*
chmod 0644 $target/.ssh/*.pub
