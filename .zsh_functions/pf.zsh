# Use pf to path fuzzily and copy the absolute path to clipboard upon selection
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

