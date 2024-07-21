# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=~/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

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

# No bell: Shut up Zsh
unsetopt beep

#Git
alias ga='git add'
alias gap='git add -p'
alias gs='git status'
alias gpr='git pull -r'
alias gl='git lg'
alias glo='git log --oneline'
alias gcm='git commit -m'
alias pear='git pair '
alias gra='git commit --amend --reset-author --no-edit'
alias gco='git checkout'
alias hangon='git stash save -u'
alias gsp='git stash pop'
alias grc='git rebase --continue'
alias gclean='git clean -df'
alias gup='gco main && gpr && gco -'
alias unwip='git reset HEAD~'
alias unroll='git reset HEAD~ --hard'
alias gpfwl='git push --force-with-lease'
alias glt='git describe --tags --abbrev=0'
alias unroll='unwip && git checkout . && git clean -df'
alias rspec_units='rspec --exclude-pattern "**/features/*_spec.rb"'
alias awsume='. awsume sso;. awsume' 
alias gprune=$'git branch --merged main | grep -v \'^[ *]*main$\' | xargs git branch -d'
alias remove_branches='git branch | grep -v "master" | xargs git branch -D'
alias fsb='~/fsb.sh'
alias fshow='~/fshow.sh'

# Tmux
# Attaches tmux to a session (example: ta portal)
alias ta='tmux attach -t'
# Creates a new session
alias tn='tmux new-session -s '
# Kill session
alias tk='tmux kill-session -t '
# Lists all ongoing sessions
alias tl='tmux list-sessions'
# Detach from session
alias td='tmux detach'
# Tmux Clear pane
alias tc='clear; tmux clear-history; clear'

alias avim="NVIM_APPNAME=AstroNvim nvim"
alias lvim="NVIM_APPNAME=LazyVim nvim"
alias kvim="NVIM_APPNAME=KickstartNvim nvim"

# Weather
alias forecast='curl "https://wttr.in/wylie?1&F&q"'
alias weather='curl "https://wttr.in/wylie?format=1"'

bindkey -e
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export BUNDLE_GITHUB__COM="${GITHUB_ACTOR}:${GITHUB_TOKEN}"
export BUNDLE_RUBYGEMS__PKG__GITHUB__COM="${GITHUB_ACTOR}:${GITHUB_TOKEN}"

export PATH="/opt/homebrew/bin:${PATH}"
PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
export PATH

if [[ ! "${PATH}" =~ "/.local/bin/?:" ]] && [[ ! "${PATH}" =~ "/.local/bin$" ]]; then 
  export PATH="${HOME}/.local/bin:${PATH}"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix openssl@3)/lib/
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source ~/fzf-git.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended --layout=reverse"
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border --layout=reverse'
fi

. /usr/local/opt/asdf/libexec/asdf.sh

# bun completions
[ -s "/Users/andrew/.bun/_bun" ] && source "/Users/andrew/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
export OPENAI_API_KEY=null
