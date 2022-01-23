# Path to your oh-my-zsh installation.
export ZSH="/home/greg/.oh-my-zsh"

ZSH_THEME="avit"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colored-man-pages
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export VISUAL=nvim
export EDITOR="$VISUAL"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias gch="git checkout"
alias gp="git push origin"
alias fto="cd ~/dev_projects/FTO"

# asdf-vm
. /home/greg/.asdf/asdf.sh
. /home/greg/.asdf/completions/asdf.bash
