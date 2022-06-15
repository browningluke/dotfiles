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

for config (~/.config/zsh/*.zsh) source $config
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
