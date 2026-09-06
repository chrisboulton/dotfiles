# Chris' dotfiles

Personal shell and application configuration, managed by [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

Install Git, then clone and run the setup script. On macOS, also install GNU Stow first (`brew install stow`):

```sh
git clone git@github.com:chrisboulton/dotfiles.git
cd dotfiles
./setup.sh
```

Supported systems:

- **Ubuntu and Debian:** installs Zsh and GNU Stow using `apt`, plus Starship and Oh My Zsh when needed, and selects Zsh as the login shell.
- **Omarchy (based on Arch):** installs Zsh and GNU Stow using `pacman`, plus Starship and Oh My Zsh when needed, while preserving the current login shell. Run `zsh` manually to use it.
- **macOS:** install any missing dependencies first (for example, `brew install stow`).

Other Linux distributions are rejected before installation.

The script links this repository's files into `$HOME`, creates the required config directories, and configures Zsh to use `.config/zsh/.zshenv`.

## Private dotfiles

Secrets, credentials, machine-specific values, and other sensitive configuration live in a separate private repository named `dotfiles-private`. Clone it beside this repository:

```text
parent-directory/
├── dotfiles/
└── dotfiles-private/
```

When `./setup.sh` finds `../dotfiles-private`, it automatically stows that repository into `$HOME` after the public dotfiles. If the directory is absent, setup simply skips it.

Public configuration can reference private files that the private repository supplies. For example, `.ssh/config` includes `~/.ssh/config-private`.

## Todo

* Add macOS packages (brew), apps, system preferences
* Add in Omarchy configuration
