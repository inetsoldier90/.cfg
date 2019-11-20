source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

if [ "$TMUX" = ""  ]; then tmux; fi

fpath=(
  ~/.zfuncs
  ~/.zfuncs/**/*~*/(CVS)#(/N)
  "${fpath[@]}"
)

autoload -Uz ssh-cloudserver scp-cloudserver

alias config='/usr/bin/git --git-dir=/home/jungbaum/.cfg/ --work-tree=/home/jungbaum'

alias rm='rm -f'
