#!/bin/bash
set -ex
target=$HOME
source="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p $target/.ssh $target/.config $target/.agents $target/.cache/zsh

stow -d $source -t $target --ignore=setup.sh -v .

if [ -d "$source/../dotfiles-private" ]; then
    stow -d $source/.. -t $target -v dotfiles-private
fi

# configure zsh to use XDG layout
ln -fs $source/.config/zsh/.zshenv $target/.zshenv

chmod 0700 $target/.ssh
chmod 0600 $target/.ssh/id*
chmod 0600 $target/.ssh/config*
chmod 0644 $target/.ssh/*.pub
