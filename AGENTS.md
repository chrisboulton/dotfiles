# Agent rules

- Keep this repository public-safe: never add secrets, credentials, tokens, private keys, sensitive hostnames, or personal machine-specific values.
- Put sensitive or private configuration in the parallel sibling repository `../dotfiles-private`, preserve the `dotfiles/` and `dotfiles-private/` sibling layout expected by `setup.sh`.
- Treat files as GNU Stow packages whose paths mirror their destinations under `$HOME`.
- Keep changes minimal and portable across macOS and Linux unless the task is explicitly platform-specific.
- Never run `./setup.sh` during validation without explicit approval because it changes `$HOME`, installs software, and may change the login shell.
