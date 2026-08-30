# Chris' dotfiles

Personal shell and application configuration, managed by [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

Install Git and GNU Stow, then clone and run the setup script:

```sh
git clone git@github.com:chrisboulton/dotfiles.git
cd dotfiles
./setup.sh
```

On Linux, the script also installs Zsh, Starship, and Oh My Zsh when needed. On macOS, install any missing dependencies first (for example, `brew install stow`).

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
* Separate out Linux into Debian systems, Omarchy, etc
* Add in Omarchy configuration
