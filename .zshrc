# ============================================================================
# zinit — plugin manager (turbo mode for fast startup)
# ============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# oh-my-zsh library snippets (git plugin aliases, tmux plugin, etc.)
zinit snippet OMZL::git.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::command-not-found

# Deferred plugins (load after prompt is shown — ice "wait" + "lucid")
# Order: compinit → fzf-tab → widget-wrapping plugins (syntax-highlighting, autosuggestions)
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        Aloxaf/fzf-tab \
    zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# ============================================================================
# Prompt
# ============================================================================
eval "$(starship init zsh)"

# ============================================================================
# Integrations
# ============================================================================
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

eval "$(zoxide init zsh --cmd cd)"

# ============================================================================
# History
# ============================================================================
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ============================================================================
# Functions
# ============================================================================
# yazi — cd to last directory on exit
function y() {
    local tmp
    tmp="$(mktemp -t yazi-cwd.XXXXX)"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ============================================================================
# Aliases
# ============================================================================
alias config='/usr/bin/git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME'
alias rm='rm -i'
alias n='nvim'
alias vim='nvim'
alias vi='nvim'
alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias tree='eza --tree --icons'
alias cat='bat --paging=never'

# ============================================================================
# Env
# ============================================================================
export EDITOR=nvim
export SUDO_EDITOR=/usr/bin/nvim
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"
