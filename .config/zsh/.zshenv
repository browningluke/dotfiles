# ====
# Global Functions
# ====

# ==== Determine platform ====

is_linux () {
  [[ $('uname') == 'Linux' ]];
}

is_darwin () {
  [[ $('uname') == 'Darwin' ]]
}

is_wsl () {
  grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null
}

# ====
# Per-Platform Fixes
# ====

if is_darwin; then
  # ====
  # Ensure correct PATH order
  # ====

  # Apple sucks and can't read the zsh docs properly. This hacky method
  # of changing the load order fixes the PATH order
  # See these gists for more details:
  # https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
  # https://gist.github.com/romanr/2c5ee2eafc284a2530cdb6b8d64d929c

  # Prevent the /etc/z(sh)* startup files from running
  unsetopt GLOBAL_RCS

  # Set checksum of /etc/zprofile
  CHECKSUMZ="703cd3c8"

  # Finally, the `/etc/zprofile` is checked for changes. This is done in case any
  # additional settings are updated in the future in that file that might not
  # want to simply ignore.
  #
  # Current contents:
  #
  # ```
  # ❯ cat /etc/zprofile
  # System-wide profile for interactive zsh(1) login shells.
  #
  # Setup user specific overrides for this in ~/.zprofile. See zshbuiltins(1)
  # and zshoptions(1) for more details.
  #
  # if [ -x /usr/libexec/path_helper ]; then
  # 	eval `/usr/libexec/path_helper -s`
  # fi
  # ```
  if [[ -v CHECKSUMZ ]]; then

    if [ "$(crc32 '/etc/zprofile')" != \
      "$CHECKSUMZ" ]; then
      echo "$(tput setaf 3)[WARNING]$(tput sgr 0) File \`/etc/zprofile\` " \
        "seems to has been changed since checkpoint. Revise last part of " \
        '`~/.zshenv\` for more info. \n' \
        "         Once done, run \"crc32 /etc/zprofile\" and add checksum to \`~/.zshenv\`"
    fi

    # It is also verified that the rest of the global files still do not exist, so
    # that invocation can still been avoided
    for file in '/etc/zshenv' '/etc/zlogin' '/etc/zlogout'; do
      if [ -f "$file" ]; then
        echo "$(tput setaf 3)[WARNING]$(tput sgr 0) File \`$file\` exists and" \
          "should not. Revise last part of \`~/.zshenv\` for more info."
      fi
    done

  else
     echo "Checksum is not set! Run \"crc32 /etc/zprofile\" and add checksum to \`~/.zshenv\" "
  fi

  # Since /etc/zprofile contents are known (or warning was given),
  # source /etc/zprofile before PATH is configured (in main section)
  # to add system paths with the correct order
  . /etc/zprofile
fi

# ====
# Main Config
# ====

# Setup XDG & ZDOTDIR vars
export XDG_CONFIG_HOME="/Users/lukebrowning/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# ==== Go ====
#export GOPATH=$HOME/go
#export GOROOT="$(/opt/homebrew/bin/brew --prefix go)/libexec"

# ==== Android Studio ====
export ANDROID_AVD_HOME="/Volumes/lrb-ssd/.android/avd"

# ==== SSH ====
# Installed from https://github.com/MichaelRoosz/homebrew-ssh/blob/main/Formula/libfido2.rb
export SSH_SK_PROVIDER="/usr/local/lib/libsk-libfido2.dylib"
export SSH_AUTH_SOCK="~/.ssh/agent"

# ==== Vault ===
export VAULT_ADDR="https://vault.browningluke.dev"

# ==== pyenv ====
export PYENV_ROOT="$HOME/.pyenv"

# ==== goenv ====
export GOENV_ROOT="$HOME/.goenv"

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
#  $GOROOT/bin
#  $GOPATH/bin
  ~/Library/Python/3.8/bin
  $ZDOTDIR/functions
  $path
)

# ==== FPATH ====
fpath=(
  $(brew --prefix)/share/zsh/site-functions
  $fpath
)

# ==== Cargo ====
# this file writes to the PATH
. "$HOME/.cargo/env"

# ==== pyenv ====
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# ==== goenv ====
# https://github.com/go-nv/goenv/issues/247#issuecomment-1464980109
export PATH="$GOENV_ROOT/bin:$PATH"
#export PATH="$GOROOT/bin:$PATH"
#export PATH="$PATH:$GOPATH/bin"

# ==== General Variables ====
export EDITOR=nvim

