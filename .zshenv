# ====
# Per-Platform Fixes
# ====

if [[ $('uname') == 'Darwin' ]]; then
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

export XDG_CONFIG_HOME="/Users/lukebrowning/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
. $ZDOTDIR/.zshenv

