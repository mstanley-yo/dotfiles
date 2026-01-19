v() {
    local socket="/tmp/nvim-$(tmux display-message -p "#{session_name}")"
    if [ -S "$socket" ]; then
        # Only send remote command if there are arguments
        if [ $# -gt 0 ]; then
            # Convert all arguments to absolute paths
            local args=()
            for arg in "$@"; do
                # Check if argument looks like a file path (not a vim command like +10)
                if [[ "$arg" != -* ]] && [[ "$arg" != +* ]]; then
                    # If path is already absolute, use as-is
                    if [[ "$arg" = /* ]]; then
                        args+=("$arg")
                    else
                        # Convert relative path to absolute, works for both existing and new files
                        args+=("$PWD/$arg")
                    fi
                else
                    # Keep flags and commands as-is
                    args+=("$arg")
                fi
            done
            command nvim --server "$socket" --remote "${args[@]}"
        else
            # Just focus the nvim pane if no arguments
            tmux select-pane -t :.+
        fi
    else
        # Check if we're in tmux
        if [ -z "$TMUX" ]; then
            echo "Error: Not in a tmux session"
            return 1
        fi
        
        # Start nvim in the other pane
        tmux select-pane -t :.+
        tmux send-keys "nvim" Enter
        
        # Only wait for socket and open files if arguments were provided
        if [ $# -gt 0 ]; then
            # Wait for the socket to be created
            local max_wait=50  # 5 seconds max
            local count=0
            while [ ! -S "$socket" ] && [ $count -lt $max_wait ]; do
                sleep 0.1
                ((count++))
            done
            
            if [ -S "$socket" ]; then
                # Convert arguments to absolute paths
                local args=()
                for arg in "$@"; do
                    if [[ "$arg" != -* ]] && [[ "$arg" != +* ]]; then
                        if [[ "$arg" = /* ]]; then
                            args+=("$arg")
                        else
                            args+=("$PWD/$arg")
                        fi
                    else
                        args+=("$arg")
                    fi
                done
                command nvim --server "$socket" --remote "${args[@]}"
            else
                echo "Error: Failed to start nvim server"
                return 1
            fi
        fi
    fi
}
