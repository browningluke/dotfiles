export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# Go
export GOPATH=$HOME/go
export GOROOT="$(/opt/homebrew/bin/brew --prefix go)/libexec"

export GPG_TTY=$(tty)
export VISUAL='vim'

# PATH
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $GOROOT/bin
  $GOPATH/bin
  ~/Library/Python/3.8/bin
  $ZDOTDIR/functions
  $path
)


# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

