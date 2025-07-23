#!/bin/bash

set -e

echo "🚀 Installing wt CLI tool..."

# Get the directory where this script is located (cross-shell compatible)
if [ -n "$BASH_SOURCE" ]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
elif [ -n "$ZSH_VERSION" ]; then
    SCRIPT_DIR="${0:A:h}"
else
    # Fallback for other shells
    SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
fi

# Determine installation directory
if [ -n "$WT_INSTALL_DIR" ]; then
    INSTALL_DIR="$WT_INSTALL_DIR"
elif [ -d "$HOME/.local/bin" ] && echo "$PATH" | grep -q "$HOME/.local/bin"; then
    # Prefer ~/.local/bin if it exists and is in PATH
    INSTALL_DIR="$HOME/.local/bin"
else
    # Fallback to ~/bin
    INSTALL_DIR="$HOME/bin"
fi

echo "📁 Installation directory: $INSTALL_DIR"

# Create installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "📁 Creating $INSTALL_DIR directory..."
    mkdir -p "$INSTALL_DIR"
fi

# Create symlink
echo "🔗 Creating symlink..."
ln -sf "$SCRIPT_DIR/wt" "$INSTALL_DIR/wt"

# Check if installation directory is in PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "📝 Adding $INSTALL_DIR to PATH..."
    
    # Detect shell and update appropriate config file
    SHELL_CONFIGS=()
    
    # Check for zsh
    if [ -f "$HOME/.zshrc" ]; then
        SHELL_CONFIGS+=("$HOME/.zshrc")
    fi
    
    # Check for bash
    if [ -f "$HOME/.bashrc" ]; then
        SHELL_CONFIGS+=("$HOME/.bashrc")
    elif [ -f "$HOME/.bash_profile" ]; then
        SHELL_CONFIGS+=("$HOME/.bash_profile")
    fi
    
    # Check for fish
    if [ -d "$HOME/.config/fish" ]; then
        SHELL_CONFIGS+=("$HOME/.config/fish/config.fish")
    fi
    
    if [ ${#SHELL_CONFIGS[@]} -eq 0 ]; then
        # No config files found, create .bashrc
        SHELL_CONFIGS+=("$HOME/.bashrc")
    fi
    
    # Add to PATH in detected config files
    for config in "${SHELL_CONFIGS[@]}"; do
        if [ -f "$config" ] || [ "$config" = "$HOME/.bashrc" ]; then
            # Check if already in config
            if ! grep -q "$INSTALL_DIR" "$config" 2>/dev/null; then
                echo "Adding to $config..."
                
                # Handle fish shell differently
                if [[ "$config" == *"fish/config.fish" ]]; then
                    mkdir -p "$(dirname "$config")"
                    echo "set -gx PATH $INSTALL_DIR \$PATH" >> "$config"
                else
                    # Bash/Zsh syntax
                    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$config"
                fi
            fi
        fi
    done
    
    echo "✅ Added $INSTALL_DIR to PATH"
    echo "⚠️  Please reload your shell configuration:"
    echo "   - For bash/zsh: source ~/.bashrc or source ~/.zshrc"
    echo "   - For fish: source ~/.config/fish/config.fish"
    echo "   - Or simply start a new terminal session"
else
    echo "✅ $INSTALL_DIR is already in PATH"
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
    echo "⚠️  Please reload your shell configuration or start a new terminal"
    echo "   Then run 'wt -h' to see usage instructions"
fi

# Display additional information
echo ""
echo "ℹ️  Installation details:"
echo "   - Executable: $INSTALL_DIR/wt"
echo "   - Source: $SCRIPT_DIR/wt"
if [ -n "$WT_INSTALL_DIR" ]; then
    echo "   - Custom install directory set via WT_INSTALL_DIR"
fi