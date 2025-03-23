# Enable debug logging
# set -x

# ====
# Per-Platform Fixes
# ====

# Since GLOBAL_RCS is disabled on MacOS,
# source /etc/zshrc to preserve order
# See ~/.zshenv
if is_darwin; then
  . /etc/zshrc
fi

# ====
# Helpers
# ====

# ....

# ====
# ZSH Setup
# ====

# ==== Znap ====
source ~/.config/zsh/plugins/zsh-snap/znap.zsh

# ==== Aliases ====
. $ZDOTDIR/.zalias.zsh
. $ZDOTDIR/.zalias.local.zsh # Contains secrets, so not in git

# ==== Functions ====
. $ZDOTDIR/.zfunc.zsh
. $ZDOTDIR/.zfunc.local.zsh # Contains secrets, so not in git

# ==== Named Directories ====
. $ZDOTDIR/.zhash.zsh

# ==== Git Branch Info ====
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '[%b]'

# ==== Prompt ====
setopt PROMPT_SUBST
PROMPT='[%2~] %# '
RPROMPT='${vcs_info_msg_0_%} %t'
ZSH_THEME=”random”

# ==== History ====
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=1000
SAVEHIST=5000

# ==== PATH ====
# Remove duplicates from PATH
typeset -U PATH path

# ==== Options ====
setopt autocd beep nomatch autopushd pushdignoredups
bindkey -e

# ==== Plugins ====
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# ====
# Autocomplete
# ====
# Mostly covered by having homebrew/site-functions in fpath (see .zshenv)

# bitwarden-cli (overrides brew to specify --no-deprecation flag)
znap fpath _bw "NODE_OPTIONS=\"--no-deprecation\" bw completion --shell zsh"
compctl -K _bw bw

znap eval _az "curl -fsSL https://raw.githubusercontent.com/Azure/azure-cli/azure-cli-2.55.0/az.completion"

complete -o nospace -C terraform terraform
complete -o nospace -C vault vault

# pip
znap function _pip_completion pip       'eval "$( pip completion --zsh )"'
compctl -K    _pip_completion pip

# ====
# Other Program Setup
# ====

# ==== pyenv ====
znap eval pyenv "pyenv init -"

# ==== goenv ====
znap eval goenv "goenv init -"

# ==== fzf ====
export FZF_ALT_C_COMMAND=""
znap eval fzf "fzf --zsh"

## Lazy load pyenv (runs pyenv init only when pyenv is first called in a shell)
#znap function _pyenv pyenv 'eval "$( pyenv init - --no-rehash )"'
#compctl -K    _pyenv pyenv

# ==== Terraform ====
export TF_PLUGIN_CACHE_DIR="/opt/tf-plugin-cache"

# ==== nvm ====
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
znap source lukechilds/zsh-nvm

# ==== ssh-ident ====
alias ssh='~/.local/bin/ssh-ident'

# ==== thefuck ====
eval $(thefuck --alias)

# ====
# Cleanup
# ====

# ==== Cleanup funcs ====
# unset -f <example>

# ====
# MOTD
# ====
fastfetch --pipe false | lolcat

