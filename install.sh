#!/bin/bash

set -e

echo "🚀 Installing wt CLI tool..."

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create ~/bin directory if it doesn't exist
echo "📁 Creating ~/bin directory..."
mkdir -p ~/bin

# Create symlink
echo "🔗 Creating symlink..."
ln -sf "$SCRIPT_DIR/wt" ~/bin/wt

# Check if ~/bin is in PATH
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "📝 Adding ~/bin to PATH..."
    
    # Detect shell and update appropriate config file
    if [[ -n "$ZSH_VERSION" ]]; then
        # Zsh
        SHELL_CONFIG="$HOME/.zshrc"
    elif [[ -n "$BASH_VERSION" ]]; then
        # Bash
        SHELL_CONFIG="$HOME/.bashrc"
    else
        # Default to bashrc
        SHELL_CONFIG="$HOME/.bashrc"
    fi
    
    # Add to PATH if not already there
    if ! grep -q '$HOME/bin' "$SHELL_CONFIG" 2>/dev/null; then
        echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_CONFIG"
        echo "✅ Added ~/bin to PATH in $SHELL_CONFIG"
        echo "⚠️  Please run: source $SHELL_CONFIG"
        echo "   Or start a new terminal session"
    fi
else
    echo "✅ ~/bin is already in PATH"
fi

# Make sure the script is executable
chmod +x "$SCRIPT_DIR/wt"

# Test installation
if command -v wt &> /dev/null; then
    echo ""
    echo "✅ Installation complete! You can now use 'wt' command."
    echo "📖 Run 'wt -h' to see usage instructions"
else
    echo ""
    echo "✅ Installation complete!"
    echo "⚠️  Please run 'source ~/.bashrc' or start a new terminal"
    echo "   Then run 'wt -h' to see usage instructions"
fi