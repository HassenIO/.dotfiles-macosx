# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/htaidirt/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell" # Default
ZSH_THEME="fishy-customized"
# ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  auto-notify
)

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

############################
#                          #
# CUSTOMISE PLUGINS        #
#                          #
############################

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,underline"

############################
#                          #
# Define helpful functions #
#                          #
############################

# cd into a directory and show content
#
function cdl() {
  cd $1
  ls -lah
}

# Check applications that are using a specific port
#
function port() {
  lsof -i :$1
}

# Search for a pattern in any file within the current directory
#
function search () {
  grep -rnw `pwd` -e $1
}

# Launch the VS Code Insiders.
# Nota: Open with current folder if no arguments.
#
function code() {
  if [ -z "$*" ]
  then
    code-insiders .
  else
    code-insiders "$*"
  fi
}

# Get my external IP address
#
function ip() {
  curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'
  # Source: http://apple.stackexchange.com/questions/20547/how-do-i-find-my-ip-address-from-the-command-line)
}

# Delete branches given a grep criteria
#
function clean-branch() {
  git branch | grep $1 | while read -r line ; do
    git branch -D $line
  done
}

# Add SSH key
#
function ssh_add() {
  /usr/bin/ssh-add -K ~/.ssh/id_rsa
}

# Get SHA256 of a text
# Source: http://albertech.blogspot.fr/2015/02/generate-sha-256-hash-from-command-line.html
#
function sha256() {
  echo -n $1 | shasum -a 256
}

# Play with Python virtual environment
#
function venv() {
  case "$1" in
    "init") python3 -m venv venv
      source venv/bin/activate
      touch requirements.txt
      ;;
    "use") source venv/bin/activate
      ;;
    "add") pip3 install $2
      pip3 freeze > requirements.txt
      ;;
    "freeze") pip3 freeze > requirements.txt
      ;;
    *) echo "Invalid option"
      ;;
  esac
}

# Drastic command to purge docker images and volumes
#
function docker_purge() {
    docker rmi -f $(docker images -q)
    docker system prune --force
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias del_ds_store="find . -name '.DS_Store' -type f -delete" # Source: https://jonbellah.com/recursively-remove-ds-store/
alias c="clear"
alias status="git status"
alias add="git add -A"
alias commit="git commit"
alias diff="git diff"
alias gc="gcloud"
alias tf="terraform"

# Save/Restore Hyper.js configs to/from Gist
export HYPER_SYNC_SETTINGS_PERSONAL_ACCESS_TOKEN="6c2a8bd1e6d993a84d0bb0626f2503158eb10f88"
export HYPER_SYNC_SETTINGS_GIST_ID="a8d692b02766e025b91ea55bde96d0c0#file-hyper-sync-settings-json"

# Export NVM settings
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Set Spaceship ZSH as a prompt
# autoload -U promptinit; promptinit
# prompt spaceship

# added by Miniconda3 installer
export PATH="/Users/htaidirt/.miniconda3/bin:$PATH"
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/htaidirt/.nvm/versions/node/v8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/htaidirt/.nvm/versions/node/v8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/htaidirt/.nvm/versions/node/v8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/htaidirt/.nvm/versions/node/v8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/htaidirt/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/htaidirt/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/htaidirt/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/htaidirt/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/htaidirt/Workspace/AXA/datastore/datastore/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/htaidirt/Workspace/AXA/datastore/datastore/node_modules/tabtab/.completions/slss.zsh

# We add terraform binary to path
export PATH="/Users/htaidirt/.terraform:$PATH"

# Go to workspace directory after boot
cd ~/Workspace

