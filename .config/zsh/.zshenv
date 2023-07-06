# ==== Go ====
export GOPATH=$HOME/go
export GOROOT="$(/opt/homebrew/bin/brew --prefix go)/libexec"

# ==== Unix General ====
export GPG_TTY=$(tty)
export VISUAL='vim'

# ==== PATH ====
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $GOROOT/bin
  $GOPATH/bin
  ~/Library/Python/3.8/bin
  $ZDOTDIR/functions
  $path
)

# ==== Cargo ====
. "$HOME/.cargo/env"

# ==== General Variables ====
export EDITOR=nvim

