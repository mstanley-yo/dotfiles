# Always cd using physical paths (resolve symlinks)
cd() { 
  builtin cd -P "$@"
}
