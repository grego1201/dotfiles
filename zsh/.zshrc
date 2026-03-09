# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/Users/gregoriopatinoesteo/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="nanotech"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages zsh-autosuggestions rails rake)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias origclean='find . -name "*.orig" -exec rm -f {} \;'
alias test_prepare='RAILS_ENV=test rake db:test:prepare'
alias migrate='bin/rake db:migrate RAILS_ENV=development'
alias console='bundle exec rails console'
fetcheck(){
  git fetch origin $1 && git checkout $1
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export VISUAL=nvim
export EDITOR="$VISUAL"

# asdf-vm
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- RVM ---
#
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export GEM_HOME="$HOME/.gem"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH="$PATH:/usr/local/rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Error tmux with rvm https://github.com/rvm/rvm/issues/3270
# https://github.com/charlietag/os_preparation/blob/master/templates/F_02_PKG_06_ruby_00_user_rubyuser/user_home/.bash_user/.rvm_setup.sh
if [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
  export rvm_previous_environment="default"
  source /usr/local/rvm/scripts/rvm
  export rvm_previous_environment="default"
  cd '.'
  if [[ -n "${TMUX}" ]]; then
    tmux setenv GEM_HOME $GEM_HOME
    tmux setenv -g GEM_HOME $GEM_HOME
    tmux setenv GEM_PATH $GEM_PATH
    tmux setenv -g GEM_PATH $GEM_PATH
  fi
fi
# --- RVM ---

# Cusotm aliases
alias gch="git checkout"
alias ci_rubocop="bundle exec rubocop $(git diff --name-only '*.rb')"
alias origclean='find . -name "*.orig" -exec rm -f {} \;'
alias local_rubocop="git diff --name-only origin/master...HEAD -- '*.rb' | xargs -I {} bash -c 'if [ -f "{}" ]; then echo {}; fi' | xargs bundle exec rubocop --force-exclusion -a --fail-level error"
alias gs="git switch"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] '$PROMPT
