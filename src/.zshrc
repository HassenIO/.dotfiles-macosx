##
#   Manipulate .zshrc file
#
export DOTFILE_ZSHRC="~/Workspace/Playground/.dotfiles/src/.zshrc"
alias change="vim $DOTFILE_ZSHRC" # Open .zshrc to be edited in VS Code
alias resource="source $DOTFILE_ZSHRC" # Re-run source command on .zshrc to update current terminal session with new settings

##
#   Update $PATH for the diffent applications and packages
#
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Packages/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Packages/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Packages/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Packages/google-cloud-sdk/completion.zsh.inc"; fi
# The next line adds Miniconda 3 to path. Ensure it is installed in ~/.miniconda3 folder
export PATH="$HOME/.miniconda3/bin:$PATH"  # Add miniconda3 to path
export PATH="$HOME/.local/bin:$PATH"
# The next line adds Go PATHs
export GOPATH="$HOME/Packages/go"
export PATH="$GOPATH/bin:$PATH"

##
# Spaceship ZSH prompt
#
autoload -U promptinit; promptinit
prompt spaceship

# Enable syntax highlighting in new shell sessions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Allow the use of the z plugin to easily navigate directories
# . ~/.dotfiles/resources/z.sh

##
#   ColorLS
#
alias l='colorls --group-directories-first --almost-all'
alias ll='colorls --group-directories-first --almost-all --long' # detailed list view

##
#   GIT setups
#
alias diff="git diff"
alias status="git status"
alias add="git add -A"
alias commit="git commit"
alias push="git push"

##
#   VIM
#
alias vinstall="vim +'PlugInstall --sync' +qa"

##
#   Add Google Cloud aliases
#
alias gc="gcloud"
alias gs="gsutil"

##
#   Add Terraform aliases
#
alias tf="terraform"

##
#   Kubernetes and environments
#
alias k="kubectl"
alias knoc="kubectl config unset current-context"

##
#   CircleCI CLI
#
if ! [ -x "$(command -v circleci)" ]; then
  echo "Installing CircleCI CLI..."
  curl -fLSs https://circle.ci/cli | bash
fi
alias ci=circleci

##
#   Helpful aliases
##
alias del_ds_store="find . -name '.DS_Store' -type f -delete"
alias ":q"="exit" # Yeah VIM habits, you know!
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias ~="cd ~"


##
#   Helpful functions
##

# Access a folder and list the content
function goto() {
  cd $1
  pwd
  colorls --group-directories-first --almost-all --long
}

# Check applications that are using a specific port
function port() {
    lsof -i :$1
}

# Search for a pattern in any file within current directory
function search() {
    if [ -z "$2" ]
    then
      grep -rnF --color $1 .
    else
      grep -rnF --color $1 $2
    fi
}

# Get my external current IP address
# Source: http://apple.stackexchange.com/questions/20547/how-do-i-find-my-ip-address-from-the-command-line)
#
function ip() {
    curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'
}

# Create and change directory
#
function take() {
    mkdir -pv "$1"
    cd "$1"
}

# Add SSH key
#
function add_ssh() {
    /usr/bin/ssh-add -K ~/.ssh/id_rsa
}

# Get SHA256 of a text
# Source: http://albertech.blogspot.fr/2015/02/generate-sha-256-hash-from-command-line.html
#
function sha256() {
    echo -n $1 | shasum -a 256
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

# Play with Python virtual environment
#
function venv() {
  case "$1" in
    "init") python3 -m venv venv
      source venv/bin/activate
      if [[ ! -f "requirements.txt" ]]; then
          touch requirements.txt
      fi
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

# Delete images based on name, no matter the tag
#
function docker_images_del() {
  docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$1")
}

# Drastic command to purge docker images and volumes
#
function docker_purge() {
  docker container rm ($docker container list -aq)
  docker rmi -f $(docker images -q)
  docker system prune --force
}

##
#   Set exports for apps
##

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# . "/usr/local/opt/nvm/nvm.sh"  # Export NVM settings

# place this after nvm initialization!
# Credential: https://medium.com/@kinduff/automatic-version-switch-for-nvm-ff9e00ae67f3
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
