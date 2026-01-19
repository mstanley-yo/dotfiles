# ~/.zsh_functions/touch.zsh
# Enhanced touch command that creates valid DOCX, Excel, and PowerPoint files

# Path to virtual environment
TOUCH_VENV="$HOME/.zsh/venv"

# Initialize virtual environment if it doesn't exist
_init_venv() {
  if [[ ! -d "$TOUCH_VENV" ]]; then
    echo "Creating virtual environment for Office file tools..."
    python3 -m venv "$TOUCH_VENV"
  fi
}

# Check and install Python dependencies
_check_python_deps() {
  _init_venv
  
  local deps_missing=false
  local missing_packages=()
  local PYTHON="$TOUCH_VENV/bin/python3"
  local PIP="$TOUCH_VENV/bin/pip"

  # Check for required Python packages
  if ! "$PYTHON" -c "import docx" 2>/dev/null; then
    missing_packages+=("python-docx")
    deps_missing=true
  fi

  if ! "$PYTHON" -c "import openpyxl" 2>/dev/null; then
    missing_packages+=("openpyxl")
    deps_missing=true
  fi

  if ! "$PYTHON" -c "import pptx" 2>/dev/null; then
    missing_packages+=("python-pptx")
    deps_missing=true
  fi

  # Install missing packages if any
  if [[ "$deps_missing" = true ]]; then
    echo "Missing Python packages detected: ${missing_packages[@]}"
    echo "Installing dependencies in virtual environment..."
    
    if "$PIP" install "${missing_packages[@]}"; then
      echo "✓ Dependencies installed successfully"
      return 0
    else
      echo "✗ Failed to install dependencies."
      return 1
    fi
  fi
  
  return 0
}

touch() {
  local created_any=false
  local needs_deps=false
  local PYTHON="$TOUCH_VENV/bin/python3"
  
  # Check if any of the arguments need Python dependencies
  for f in "$@"; do
    case "$f" in
      *.docx|*.xlsx|*.xls|*.pptx)
        needs_deps=true
        break
        ;;
    esac
  done
  
  # Only check dependencies if needed
  if [[ "$needs_deps" = true ]]; then
    if ! _check_python_deps; then
      echo "Warning: Cannot create Office files without dependencies. Creating empty files instead."
    fi
  fi
  
  # Process each file
  for f in "$@"; do
    case "$f" in
      *.docx)
        if [[ ! -e "$f" ]]; then
          # Create minimal valid DOCX
          if "$PYTHON" -c "import docx" 2>/dev/null; then
            "$PYTHON" - <<EOF
from docx import Document
Document().save("$f")
EOF
            created_any=true
            echo "Created Word document: $f"
          else
            command touch "$f"
          fi
        fi
        ;;
      *.xlsx|*.xls)
        if [[ ! -e "$f" ]]; then
          # Create minimal valid Excel file
          if "$PYTHON" -c "import openpyxl" 2>/dev/null; then
            "$PYTHON" - <<EOF
from openpyxl import Workbook
Workbook().save("$f")
EOF
            created_any=true
            echo "Created Excel spreadsheet: $f"
          else
            command touch "$f"
          fi
        fi
        ;;
      *.pptx)
        if [[ ! -e "$f" ]]; then
          # Create minimal valid PowerPoint file
          if "$PYTHON" -c "import pptx" 2>/dev/null; then
            "$PYTHON" - <<EOF
from pptx import Presentation
Presentation().save("$f")
EOF
            created_any=true
            echo "Created PowerPoint presentation: $f"
          else
            command touch "$f"
          fi
        fi
        ;;
      *)
        command touch "$f"
        ;;
    esac
  done
  
  return 0
}
