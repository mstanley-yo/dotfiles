# Change ls to have colours
# Reference: https://geoff.greer.fm/lscolors/

ls() {
  case "$(uname)" in
    Darwin)
      # macOS / BSD ls
      export LSCOLORS="gxfxcxdxbxegedabagacad"
      command ls -G -F "$@"
      ;;
    Linux)
      # Linux / GNU ls
      export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31"
      command ls --color=auto -F "$@"
      ;;
    *)
      # Fallback
      command ls -F "$@"
      ;;
  esac
}

