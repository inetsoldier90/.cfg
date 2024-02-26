source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen theme denysdovhan/spaceship-prompt

antigen bundle git
antigen bundle tmux
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting

ZSH_TMUX_AUTOSTART=false

antigen apply


fpath=(
    ~/.zfuncs
    ~/.zfuncs/**/*~*/(CVS)#(/N)
    "${fpath[@]}"
)

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias rm='rm -f'

export GOPATH=$HOME/dev/golang

source "$HOME/.cargo/env"
export PATH="$PATH:/mnt/d/BIN/:$GOPATH/bin:/usr/local/go/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

