## Aliases ##

# General
alias l="ls -l"
alias la="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias grep="grep --color=auto"
alias cp="cp -r"
alias ..="cd ../"
alias ...="cd ../.."
alias ....="cd ../../.."
alias ltree="tree -L 1"
alias updatedb="/usr/libexec/locate.updatedb"

# tmux
alias tma="tmux att -t"
alias tmls="tmux ls"

# Bundler
alias b="bundle"
alias be="bundle exec"

# Elixir
alias imix="iex -S mix"
alias server="iex -S mix phoenix.server"

# Git
alias co="git checkout"
alias g="git"
alias gap="git add -p"
alias gc="git commit -v"
alias gcm="git checkout master"
alias gco="git checkout"
alias gp="git push origin HEAD"
alias gpoh="git push origin HEAD"
alias gpull="git pull"
alias gpush="git push"
alias grm="git pull --rebase origin master"
alias gs="git status"
alias gst="git status"
alias gsu="git submodule update"
alias gupdate="git pull && git-clean -y"
alias s="git status"

# Vim
alias vim="nvim"

## User configuration ##

# History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.history
setopt SHARE_HISTORY

# Emacs
set -o emacs

# Path VARs
export GOPATH="$HOME/code/gocode:/code/work/pgnetdetective"
export PATH="/usr/local/bin:/usr/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.multirust/toolchains/stable/cargo/bin:$PATH"
export PATH="$HOME/.multirust/toolchains/beta/cargo/bin:$PATH"
export PATH="$HOME/.multirust/toolchains/nightly/cargo/bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# Start rbenv
if type rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

# pyenv
export PATH="/Users/username/.pyenv:$PATH"
eval "$(pyenv init -)"

# Default Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Path Settings
# - MATTCASPER.local work/go/action_tracker_queue (master) $
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M '
zstyle ':vcs_info:*' unstagedstr 'M '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}(%F{2}%b%F{5}) %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git

precmd () { vcs_info }
PROMPT='%F{5} - %F{2}%M%F{5} %F{3}%3~ ${vcs_info_msg_0_}%f$ '

# Source FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source and load Git completion
autoload -Uz compinit && compinit

# Z
source `brew --prefix`/etc/profile.d/z.sh

# Cargo
if [ -d "$HOME/.cargo" ]; then
  source "$HOME/.cargo/env"
fi

# Kiex
[ -f "$HOME/.kiex/scripts/kiex" ] && source "$HOME/.kiex/scripts/kiex"

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# Base16
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

fpath+=~/.zfunc

export PATH="./bin:$PATH"
