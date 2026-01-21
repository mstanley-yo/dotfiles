# Initialise zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins using zinit for syntax highlighting + completion
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
autoload -Uz compinit && compinit

# Change to vim keybindings
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# De-dupe history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=eraseœ
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Change ls colors - reference https://geoff.greer.fm/lscolors/
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31"
export LSCOLORS="gxfxcxdxbxegedabagacad"

# Replace zsh's default completion selection menu with fzf
zinit light Aloxaf/fzf-tab
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:*' fzf-flags --ansi
zstyle ':fzf-tab:*' fzf-preview ""

# alias important directories
export GD="$HOME/Library/CloudStorage/GoogleDrive-maximilianstanleyyo1@gmail.com/My Drive"
export SV="$GD/Post-Graduate/SystemsVirology"
export YY="$GD/YY"
export THESIS="$YY/CBMS/THESIS"
export PCOV="$SV/20240409_GDpCoV519/_writeup"

# alias CLI tools
alias pip="pip3"
alias py="python3"
alias python="python3"
alias rr="Rscript"

# set nvim as default editor
export EDITOR=nvim

# use git to track dotfiles (including .zshrc)
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias common bash commands and improvements
alias pb="pbcopy"
alias ls='ls -G -F'
alias c="clear"

# Source all custom functions if directory exists
if [[ -d ~/.zsh_functions ]]; then
  for function_file in ~/.zsh_functions/*.zsh; do
    [[ -f "$function_file" ]] && source "$function_file"
  done
fi

# Load private secrets if present
if [[ -f ~/.zshrc.private ]]; then
  source ~/.zshrc.private
fi

# configure starship
if ! command -v starship >/dev/null 2>&1; then
  echo "Starship not found. Installing..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
eval "$(starship init zsh)"

# Configure path
export PATH="$PATH:/$HOME/.config/bin" # personal scripts
export PATH="$PATH:/$HOME/.local/bin"
export PYTHONPATH=/$HOME/Python/mylib/
