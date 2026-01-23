vnv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        deactivate
    else
        if [ -f .venv/bin/activate ]; then
            source .venv/bin/activate
        else
            echo "No .venv/bin/activate found in current directory"
            return 1
        fi
    fi
}
