# ==== Go ====
export GOPATH=$HOME/go
export GOROOT="$(/opt/homebrew/bin/brew --prefix go)/libexec"

# ==== SSH ====
# Installed from https://github.com/MichaelRoosz/homebrew-ssh/blob/main/Formula/libfido2.rb
export SSH_SK_PROVIDER="/usr/local/lib/libsk-libfido2.dylib"

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

