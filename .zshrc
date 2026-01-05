# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
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
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-preview '
if [ -d "$realpath" ]; then
  ls --color "$realpath"
elif file --mime-type -b "$realpath" | grep -q "^image/"; then
  chafa --size=80x40 "$realpath"
elif file -b "$realpath" | grep -q text; then
  bat --style=numbers --color=always --line-range=:300 "$realpath"
else
  file "$realpath"
fi'

# Use pf to preview files and copy the absolute path to them upon selection
typeset -ga FZF_PREVIEW_OPTS=(
  --ansi
  --preview '
    if [ -d {} ]; then
      ls --color {}
    elif file --mime-type -b {} | grep -q "^image/"; then
      chafa --size=80x40 {}
    elif file -b {} | grep -q text; then
      bat --style=numbers --color=always --line-range=:300 {}
    else
      file {}
    fi
  '
)

pf() {
  local file
  file=$(ls --color | fzf $FZF_PREVIEW_OPTS) || return
  echo "'$PWD/$file'" | pbcopy
  echo "Copied: $PWD/$file"
}

# alias important directories
export GD="$HOME/Library/CloudStorage/GoogleDrive-maximilianstanleyyo1@gmail.com/My Drive"
export SV="$GD/Post-Graduate/SystemsVirology"
export YY="$GD/YY"
export THESIS="$YY/CBMS/THESIS"
export PCOV="$SV/20240409_GDpCoV519/_writeup"

# personal scripts
alias bgt="Rscript '$YY/Budget/viz_budget.R'"
alias obs="python3 '$YY/obsidian.py'"
alias leetcode="python3 $HOME/Python/leetcode/get_leetcode.py"

# alias CLI tools
alias pip="pip3"
alias py="python3"
alias rr="Rscript"
alias nvim='nvim --listen /tmp/nvim'
alias v='nvim --server /tmp/nvim --remote' # open in nvim

# use git to track dotfiles (including .zshrc)
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias common bash commands and improvements
alias pb="pbcopy"
alias ls='ls -G -F'
alias c="clear"

# Always cd using physical paths (resolve symlinks)
cd() { 
  builtin cd -P "$@"
}

# Override touch to create real Word / Excel files when needed. Needs pip install python-docx openpyxl
touch() {
  local created_any=false
  for f in "$@"; do
    case "$f" in
      *.docx)
        if [[ ! -e "$f" ]]; then
          # Create minimal valid DOCX
          python3 - <<EOF
from docx import Document
Document().save("$f")
EOF
          created_any=true
        fi
        ;;
      *.xlsx|*.xls)
        if [[ ! -e "$f" ]]; then
          # Create minimal valid Excel file
          python3 - <<EOF
from openpyxl import Workbook
Workbook().save("$f")
EOF
          created_any=true
        fi
        ;;
      *)
        command touch "$f"
        ;;
    esac
  done
  return 0
}

# Load private secrets if present
if [[ -f ~/.zshrc.private ]]; then
  source ~/.zshrc.private
fi

# make neovim the default editor
export EDITOR=nvim

# configure starship
if ! command -v starship >/dev/null 2>&1; then
  echo "Starship not found. Installing..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
eval "$(starship init zsh)"

# Configure path
export PATH="$PATH:/Users/stanleyyo/Scripts"
export PATH="$PATH:/Users/stanleyyo/.local/bin" # add pipx to PATH
