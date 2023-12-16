# ==== Helpers ====
# Determine platform
is_linux () {
  [[ $('uname') == 'Linux' ]];
}

is_osx () {
  [[ $('uname') == 'Darwin' ]]
}

is_wsl () {
  grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null
}

# Source all - 'local' func (cleaned up)
source_all() {
    # Ignore null matches
    if (( $# < 1 )); then
        return
    fi

    for file in "$@"; do;
        . "$file"
    done
}

# ==== Znap ====
source ~/.config/zsh/plugins/zsh-snap/znap.zsh

# ==== Aliases ====
source_all $ZDOTDIR/.alias_*(N) # *(N) is the 'N glob quantifier'

# ==== Functions ====
source_all $ZDOTDIR/.func_*(N)

# ==== Named Directories ====
source_all $ZDOTDIR/.hash_*(N)

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

# ==== ZSH History ====
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=1000
SAVEHIST=5000

# ==== ZSH Options ====
setopt autocd beep nomatch autopushd pushdignoredups
bindkey -e

# ==== Plugins ====
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# ==== pyenv ====
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# Lazy load pyenv (runs pyenv init only when pyenv is first called in a shell) 
znap function _pyenv pyenv 'eval "$( pyenv init - --no-rehash )"'
compctl -K    _pyenv pyenv

# ==== Terraform ====
export TF_PLUGIN_CACHE_DIR="/opt/tf-plugin-cache"

# ==== Autocomplete ====
znap fpath _kubectl 'kubectl completion zsh'
znap fpath _helm 'helm completion zsh'
znap fpath _gh 'gh completion -s zsh'

complete -o nospace -C terraform terraform

# pip
znap function _pip_completion pip       'eval "$( pip completion --zsh )"'
compctl -K    _pip_completion pip

# ==== SSH ====
export SSH_AUTH_SOCK="~/.ssh/agent"

# ==== MOTD ====
neofetch | lolcat


# ==== Cleanup all 'local' vars/funcs ====
unset -f source_all

# ==== Archive ====
# The following lines were added by compinstall (commented out because of zsh-autocomplete-plugin)

#zstyle ':completion:*' completer _expand _complete _ignored _approximate
#zstyle ':completion:*' matcher-list ''
#zstyle :compinstall filename '/home/luke/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall

