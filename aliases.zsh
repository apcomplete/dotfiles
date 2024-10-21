# Terminal
alias ll='ls -alF'
alias reload!='. ~/.zshrc'

alias git=hub

alias jest='nocorrect jest'

# devcontainers
alias dcu='devcontainer up --workspace-folder ./'
alias dce='devcontainer exec --workspace-folder ./'

if [[ ! -x $(command -v pbcopy) ]]; then
  # On linux we can still do a pbcopy like thing
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# Utilities
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative --color=always"

