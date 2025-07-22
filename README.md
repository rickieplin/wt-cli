# wt - Git Worktree CLI Helper

A simple and intuitive command-line tool for managing Git worktrees, making it easier to work on multiple features or tasks simultaneously without switching branches in your main repository.

## Description

`wt` (worktree) is a Bash script that simplifies Git worktree management by providing easy-to-use commands for creating, navigating, and cleaning up worktrees. It follows a consistent naming convention and helps maintain a clean workspace.

## Features

- 🚀 Create worktrees with a single command
- 📁 Easy navigation between worktrees
- 📋 List all active worktrees
- 🧩 Merge and cleanup finished work
- 🧹 Delete worktrees without merging
- 🌿 Consistent branch naming (`tmp/<task-name>`)
- 📍 Predictable worktree locations (`../<project>-<task-name>`)

## Installation

### Prerequisites

- Git (already installed on most systems)
- Bash shell
- Linux/macOS/WSL environment

### Quick Installation

#### Option 1: One-line installer
```bash
git clone https://github.com/rickieplin/wt-cli.git ~/tools/wt-cli && cd ~/tools/wt-cli && ./install.sh
```

#### Option 2: Manual installation

1. Clone this repository:
   ```bash
   git clone https://github.com/rickieplin/wt-cli.git ~/tools/wt-cli
   ```

2. Run the installer:
   ```bash
   cd ~/tools/wt-cli
   ./install.sh
   ```

#### Option 3: Manual steps

1. Clone this repository:
   ```bash
   git clone https://github.com/rickieplin/wt-cli.git ~/tools/wt-cli
   ```

2. Make the script executable:
   ```bash
   chmod +x ~/tools/wt-cli/wt
   ```

3. Create a symlink in your PATH:
   ```bash
   mkdir -p ~/bin
   ln -s ~/tools/wt-cli/wt ~/bin/wt
   ```

4. Add `~/bin` to your PATH (if not already there):
   ```bash
   echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

5. Verify installation:
   ```bash
   wt -h
   ```

## Usage Examples

### Start a new task
```bash
# Create a new worktree for a feature
wt start feature-login

# This creates:
# - Worktree at: ../myproject-feature-login/
# - Branch: tmp/feature-login (based on main)
```

### Navigate to a worktree
```bash
# Open a subshell in the worktree directory
wt cd feature-login
```

### List all worktrees
```bash
wt list
```

### Finish a task (merge and cleanup)
```bash
# Merges tmp/feature-login into main, then removes worktree and branch
wt finish feature-login
```

### Delete without merging
```bash
# Remove worktree and branch without merging
wt delete feature-login
```

## Commands

| Command | Description |
|---------|-------------|
| `wt start <task-name>` | Create a new worktree with branch `tmp/<task-name>` based on `main` |
| `wt cd <task-name>` | Change directory to the worktree (opens a subshell) |
| `wt list` | List all current worktrees |
| `wt finish <task-name>` | Merge branch into `main`, remove worktree and delete branch |
| `wt delete <task-name>` | Remove worktree and delete branch without merging |
| `wt -h`, `wt --help`, `wt help` | Display help message |

## Workflow Example

```bash
# Start working on a new feature
wt start user-authentication

# Navigate to the worktree
wt cd user-authentication

# Work on your feature...
# (make changes, commits, etc.)

# When done, exit the subshell
exit

# Merge your work back to main
wt finish user-authentication
```

## Configuration

The tool uses the following conventions:

- **Base branch**: `main` (all worktrees branch from here)
- **Branch naming**: `tmp/<task-name>`
- **Worktree location**: `../<project-name>-<task-name>/`

## Troubleshooting

### "Not in a Git repository" error
Make sure you run `wt` commands from within a Git repository.

### "Branch already exists" error
A branch with that name already exists. Either finish/delete the existing task or choose a different name.

### "Worktree not found" error
The worktree doesn't exist. Use `wt list` to see available worktrees.

## License

MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
