# omarchy seems to love bash and it's deeply integrated, so for omarchy systems
# i guess we'll keep this around with minimum config

# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# in case there are non-omarchy bash systems in the future..
[[ -r "$OMARCHY_PATH/default/bash/rc" ]] && source "$OMARCHY_PATH/default/bash/rc"

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"
