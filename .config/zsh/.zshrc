export PATH="./bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=$PATH:$HOME/go/bin
export PATH="$HOME/.local/bin:$PATH"

export ZSH="${HOME}/.oh-my-zsh"

export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export TERM="xterm-256color"
export CLICOLOR=1

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# ZDOTDIR is a synced directory, so ensure we dont sync history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HIST_STAMPS="yyyy-mm-dd"

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$HOST"

plugins=(
  git
)

[ -d /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
[ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

export LSCOLORS=ExFxCxDxBxegedabagacad

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# C_RESET="%f"
# C_BLUE="%F{12}"
# C_ORANGE="%F{179}"
# C_RED="%F{9}"
# C_GREEN="%F{10}"
# C_YELLOW="%F{11}"

# setopt PROMPT_SUBST

autoload -U add-zsh-hook
# autoload -Uz vcs_info

# # VCS style formats.
# FMT_UNSTAGED="%{$C_RESET%} %{$C_ORANGE%}●"
# FMT_STAGED="%{$C_RESET%} %{$C_GREEN%}+"
# FMT_ACTION="(%{$C_GREEN%}%a%{$C_RESET%})"
# FMT_VCS_STATUS=":%{$C_GREEN%}%b%u%c%{$C_RESET%}"

# zstyle ':vcs_info:*' enable git svn
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' unstagedstr    "${FMT_UNSTAGED}"
# zstyle ':vcs_info:*' stagedstr      "${FMT_STAGED}"
# zstyle ':vcs_info:*' actionformats  "${FMT_VCS_STATUS} ${FMT_ACTION}"
# zstyle ':vcs_info:*' formats        "${FMT_VCS_STATUS}"
# zstyle ':vcs_info:*' nvcsformats    ""
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# # Check for untracked files.
# +vi-git-untracked() {
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#             git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
#         hook_com[staged]+="%{$C_RESET%} %{$C_RED%}●"
#     fi
# }

# add-zsh-hook precmd vcs_info

# # Oxide prompt style.
# PROMPT=$'%{$C_YELLOW%}%~%{$C_RESET%}${vcs_info_msg_0_}%(?.%{%F{white}%}.%{$C_RED%})%{$C_RESET%} $ '

if [[ -s /opt/homebrew/bin/mise ]]; then
  eval "$(/opt/homebrew/bin/mise activate zsh)"
elif [[ -s /opt/homebrew/bin/rbenv ]]; then
  eval "$(rbenv init - zsh)"
fi

[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

gcloud_paths=(
  /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/
  /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/
)
for p in $gcloud_paths; do
  if [ -f "${p}/path.zsh.inc" ]; then
    . "${p}/path.zsh.inc"
    . "${p}/completion.zsh.inc"
  fi
done

[[ -s "${HOME}/.config/op/plugins.sh" ]] && source ${HOME}/.config/op/plugins.sh

if which eza > /dev/null; then
  alias ls='eza --group-directories-first --icons'
fi
# alias ls='ls -Fa'

# bun completions
[ -s "~/.bun/_bun" ] && source "~/chris/.bun/_bun"

[ -d "$HOME/.cargo/" ] && source "$HOME/.cargo/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Vite+ bin (https://viteplus.dev)
[ -f "$HOME/.vite-plus/env" ] && source "$HOME/.vite-plus/env"

eval "$(starship init zsh)"
