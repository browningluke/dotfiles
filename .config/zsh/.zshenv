# ==== Go ====
export GOPATH=$HOME/go
export GOROOT="$(/opt/homebrew/bin/brew --prefix go)/libexec"

# ==== SSH ====
# Installed from https://github.com/MichaelRoosz/homebrew-ssh/blob/main/Formula/libfido2.rb
export SSH_SK_PROVIDER="/usr/local/lib/libsk-libfido2.dylib"

# ==== Vault ===
export VAULT_ADDR="https://vault.browningluke.dev"

# ==== Unix General ====
export GPG_TTY=$(tty)
export VISUAL='vim'

# XDG
export XDG_DATA_DIRS="/opt/homebrew/share:$XDG_DATA_DIRS"

# ==== PATH ====
path=(
  ~/.local/bin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $GOROOT/bin
  $GOPATH/bin
  ~/Library/Python/3.8/bin
  $ZDOTDIR/functions
  $path
)

# ==== FPATh ====
fpath=(
  $(brew --prefix)/share/zsh/site-functions
  $fpath
)

# ==== Cargo ====
. "$HOME/.cargo/env"

# ==== General Variables ====
export EDITOR=nvim

