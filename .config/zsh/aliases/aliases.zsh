# Docker
alias d="docker"
alias c="docker compose"

alias k="kubectl"
alias h="helm"

# Git
alias y="yadm"
alias g="git"


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

