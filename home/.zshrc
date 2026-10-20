# Start zellij in every interactive terminal. Exit the shell only when zellij
# exits cleanly; if zellij fails to launch, fall back to a plain zsh.
if [[ -o interactive && -z "$ZELLIJ" ]] && command -v zellij >/dev/null; then
  if zellij; then
    exit
  else
    print -u2 "zellij failed to start (exit $?) - continuing in plain zsh"
  fi
fi

# Powerlevel10k instant prompt. Keep close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# ---- Oh My Zsh ----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  docker
  sudo
  zsh-autosuggestions
  fzf-tab
  zsh-syntax-highlighting
)
source "$ZSH/oh-my-zsh.sh"

# ---- Toolchains ----
eval "$(mise activate zsh)"

# ---- fzf (Ctrl+R history, Ctrl+T files, Alt+C cd) ----
export FZF_DEFAULT_OPTS="--color=fg:#CBE0F0,bg:#011628,hl:#B388FF,fg+:#CBE0F0,bg+:#143652,hl+:#B388FF,info:#06BCE4,prompt:#2CF9ED,pointer:#2CF9ED,marker:#2CF9ED,spinner:#2CF9ED,header:#2CF9ED"
source <(fzf --zsh)

# ---- Aliases ----
alias ls="eza --color=always --long --git --icons=always"
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cd='z'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias n='nvim'
alias g='git'
alias d='docker'
alias lzg='lazygit'
alias lzd='lazydocker'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'
alias gitcp='git cherry-pick'
alias gitlg='git log --pretty=format:"%h - %an, %ad : %s"'
alias kres='kubectl rollout restart deployment'
alias kexec='kubectl exec -ti'
alias kpods='kubectl get pods'
alias zrs='zellij action rename-session'
alias sshadd='ssh-add --apple-use-keychain ~/.ssh/id_ed25519'
alias decompress='tar -xzf'

compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
killport() { lsof -ti ":$1" | xargs kill -9; }

# Docker via colima
export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

# macOS default open-file limit (256) is too low for Node and large builds.
ulimit -n 524288

# Machine-specific settings and secrets live outside the repo.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Prompt: run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# zoxide must be initialised last.
eval "$(zoxide init zsh)"

# Block cursor.
printf '\e[2 q'
