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

#for config (~/.config/zsh/*.zsh) source $config
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Aliases
[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh
[[ -f $ZDOTDIR/aliases.zsh.local ]] && source $ZDOTDIR/aliases.zsh.local

# Functions
[[ -f $ZDOTDIR/functions.zsh.local ]] && source $ZDOTDIR/functions.zsh.local

PROMPT="[%2~] %# "
RPROMPT="%n %t"
ZSH_THEME=”random”

neofetch | lolcat


## -- Added by tools ---

# The following lines were added by compinstall (commented out because of zsh-autocomplete-plugin)

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list ''
zstyle :compinstall filename '/home/luke/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000
setopt autocd beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

