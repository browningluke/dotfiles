# ====
# Shortenings
# ====

alias d="docker"
alias c="docker compose"

alias k="kubectl"
alias h="helm"

alias v="nvim"

alias g="git"
alias y="yadm"

alias ap='ansible-playbook'

# ====
# Shell / ZSH
# ====

alias ls='ls --color=auto'
alias l.='ls -d .*'
alias ll='ls -l'

alias zr='source $HOME/.zshenv && source ${ZDOTDIR:-$HOME}/.zshrc'

# Directory navigation
alias d='dirs -v | head -10'
alias d1='cd +1'
alias d2='cd +2'
alias d3='cd +3'
alias d4='cd +4'
alias d5='cd +5'
alias d6='cd +6'
alias d7='cd +7'
alias d8='cd +8'
alias d9='cd +9'

# ====
# Default
# ====

# Every time I go to use a tool I haven't used in a while,
# I forget the CLI flags/args I liked. This alias file will
# contain aliases for the tools (& their flags/args) that are
# the 'default' for my usage.

alias dft_scrcpy="scrcpy -wS"


alias uvenv="uv venv --seed --relocatable && source .venv/bin/activate"

# ====
# Git
# ====

# git/yadm aliases
alias yc="yadm commit -m"
alias yd="yadm diff"
alias yp="yadm push"

alias ytree="yadm log -oneline --graph --color --all --decorate"

alias gpurge='git branch --merged | grep -Ev "(\*|master|develop|staging)" | xargs -n 1 git branch -d'

alias gr='cd "$(git root)"'

# ====
# Terraform
# ====

alias tf='terraform'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tff='terraform fmt'
alias tfi='terraform init'
alias tfo='terraform output'
alias tfp='terraform plan'
alias tfv='terraform validate'

# ====
# K8s
# ====
alias k-get-token='kubectl create token -n kubernetes-dashboard admin-user --duration 100h | pbcopy'

# ====
# WSL
# ====

if is_wsl; then
  # Windows Apps
  export PATH=/mnt/c/ProgramData/chocolatey/bin/adb.exe:/mnt/c/ProgramData/chocolatey/bin/scrcpy.exe:$PATH
  alias adb='adb.exe'
  alias scrcpy='scrcpy.exe -w -S'
  alias expl="explorer.exe"
fi

# ====
# Misc
# ====

alias ts-watch='npx tsc -w -p .'
alias pip='echo "Using uv instead...."; uv pip'

