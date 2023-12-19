# ==== Go ====
export GOPATH=$HOME/go
export GOROOT="$(/opt/homebrew/bin/brew --prefix go)/libexec"

# ==== Android Studio ====
export ANDROID_AVD_HOME="/Volumes/lrb-ssd/.android/avd"

# ==== SSH ====
# Installed from https://github.com/MichaelRoosz/homebrew-ssh/blob/main/Formula/libfido2.rb
export SSH_SK_PROVIDER="/usr/local/lib/libsk-libfido2.dylib"

# ==== Vault ===
export VAULT_ADDR="https://vault.browningluke.dev"

# ==== pyenv ====
export PYENV_ROOT="$HOME/.pyenv"


# ==== Unix General ====
export GPG_TTY=$(tty)
export VISUAL='vim'

# XDG
export XDG_DATA_DIRS="/opt/homebrew/share:$XDG_DATA_DIRS"

# ==== PATH ====
# Since Apple sucks and can't read the zsh docs properly,
# this hacky method of conditionally loading the path is used:
# https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
# https://www.zsh.org/mla/users/2003/msg00600.html

# Only source path here if not in a login shell
# .zprofile handles login shell case
if [[ ! -o LOGIN ]]; then
  . $ZDOTDIR/.zpath
fi

# ==== General Variables ====
export EDITOR=nvim

