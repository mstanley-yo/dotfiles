nvim() {
    local socket="/tmp/nvim-$(tmux display-message -p "#{session_name}" 2>/dev/null || echo "default")"
    rm -f "$socket" 2>/dev/null
    command nvim --listen "$socket" "$@"
}
