# Docker
alias d="docker"
alias c="docker compose"

alias k="kubectl"
alias h="helm"

# Git
alias g="git"

alias  y="yadm"
alias yc="yadm commit -m"
alias yd="yadm diff"
alias yp="yadm push"

alias g-tree="git log --oneline --graph --color --all --decorate"
alias y-tree="yadm log --oneline --graph --color --all --decorate"

# Misc
alias v="vim"
alias ls="ls --color=auto"
alias ts-watch='npx tsc -w -p .'

# External programs
eval $(thefuck --alias)

# WSL
if is_wsl; then
        # Windows Apps
        export PATH=/mnt/c/ProgramData/chocolatey/bin/adb.exe:/mnt/c/ProgramData/chocolatey/bin/scrcpy.exe:$PATH
        alias adb='adb.exe'
        alias scrcpy='scrcpy.exe -w -S'
        alias expl="explorer.exe"
fi

