# Zsh autocomplete
#source /home/ubuntu/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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

PROMPT="[%2~] %# "
RPROMPT="%n %t"
ZSH_THEME=”random”

for config (~/.config/zsh/functions/*.zsh) source $config # source functions
for config (~/.config/zsh/aliases/*.zsh) source $config # source aliases

neofetch | lolcat

