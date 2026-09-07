# Agent Setup Guide

This file is for AI agents (Claude Code or similar) to set up these dotfiles on a fresh macOS machine. Follow the steps in order — each depends on the previous one succeeding.

---

## Prerequisites check

Before running any commands, verify the machine state:

```bash
# Check Xcode CLT
xcode-select -p 2>/dev/null && echo "CLT ok" || echo "CLT MISSING — install first"

# Check architecture (script installs Homebrew at different paths on Intel vs Apple Silicon)
uname -m
```

If `CLT MISSING`, you cannot proceed. Prompt the user to run `xcode-select --install` manually and confirm completion before continuing. This requires a GUI interaction and cannot be automated.

---

## Step 1 — Run the install script

```bash
cd /path/to/this/dotfiles/directory
chmod +x install.sh
./install.sh
```

Expected output ends with: `✓ Done!`

If any step fails, the script exits immediately (`set -e`). Common failure modes:

- Homebrew install fails: usually a network issue or missing Xcode CLT
- Oh My Zsh install fails: check if `~/.oh-my-zsh` already exists; if so, skip is expected

---

## Step 2 — Set git identity

These are never stored in dotfiles:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Verify:

```bash
git config --global user.name
git config --global user.email
```

---

## Step 3 — Verify symlinks

```bash
ls -la ~/.config/nvim ~/.config/ghostty ~/.zshrc ~/.p10k.zsh
```

All four should show `->` pointing into the dotfiles directory. `~/.gitconfig` is intentionally NOT a symlink — verify it separately:

```bash
cat ~/.gitconfig       # should show an [include] path pointing into the dotfiles dir
git config --get alias.st   # should print "status" — confirms the include is working
```

---

## Step 4 — Install Neovim plugins

Neovim plugins cannot be installed headlessly — lazy.nvim requires a terminal session. Instruct the user to:

1. Open Ghostty (or any terminal)
2. Run `nvim`
3. Wait for lazy.nvim's progress UI to complete
4. Run `:q` then reopen `nvim`
5. Verify with `:Lazy` — all plugins should show a green checkmark

If plugins fail to install, check internet access and run `:Lazy sync` to retry.

---

## Step 5 — Install Mason tools

Inside Neovim, run each of the following. Wait for each to complete before running the next.

**Core (always install):**

```
:MasonInstall stylua prettier eslint_d ruff
```

**C# support (optional - skip if you're not using C#)** — only if .NET SDK is installed. Check first:

```bash
dotnet --version 2>/dev/null || echo "dotnet not installed"
```

If dotnet is available:

```
:MasonInstall csharpier
```

If not, prompt user: `brew install --cask dotnet-sdk` (requires password; cannot be automated).

**Python formatters** — only if Python is installed via Homebrew:

```bash
brew list python 2>/dev/null || echo "python not installed"
```

If available:

```
:MasonInstall black isort
```

---

## Step 6 — Verification checklist

Run these checks and report pass/fail for each:

| Check            | Command                                               | Expected                                      |
| ---------------- | ----------------------------------------------------- | --------------------------------------------- |
| Symlinks exist   | `ls -la ~/.config/nvim ~/.config/ghostty ~/.p10k.zsh` | All show `->`                                 |
| Git identity set | `git config --global user.name`                       | Non-empty                                     |
| nvim launches    | `nvim --version`                                      | Version string                                |
| eza works        | `eza --version`                                       | Version string                                |
| Homebrew ok      | `brew doctor`                                         | `Your system is ready to brew.` (warnings ok) |

---

## File map

```
dotfiles/
├── ghostty/
│   └── config              # Ghostty theme + font settings
├── git/
│   └── .gitconfig          # Portable git settings (no name/email)
├── nvim/
│   ├── init.lua            # Entry point: leader key, options, lazy.nvim bootstrap
│   ├── CHEATSHEET.md       # Keybindings reference
│   ├── lazy-lock.json      # Plugin version lock file
│   └── lua/plugins/
│       ├── actions-preview.lua # Code action diff preview (leader-ca)
│       ├── catppuccin.lua  # Colorscheme
│       ├── completions.lua # nvim-cmp + LuaSnip
│       ├── conform.lua     # Formatter (format-on-save)
│       ├── lsp.lua         # Mason + mason-lspconfig + LSP keymaps
│       ├── lualine.lua     # Status bar
│       ├── neo-tree.lua    # File explorer (Space e)
│       ├── nvim-lint.lua   # Async linting on save
│       ├── roslyn.lua      # C# LSP (Roslyn)
│       ├── telescope.lua   # Fuzzy finder (Space ff / fg / fb / fh)
│       └── treesitter.lua  # Syntax + folding
├── zsh/
│   ├── .zshrc              # Oh My Zsh config + aliases
│   └── .p10k.zsh           # Powerlevel10k prompt config (generated by `p10k configure`)
├── install.sh              # Automated setup script
├── README.md               # Human-readable setup guide
└── AGENT_SETUP.md          # This file
```

---

## Modifying configs

All files are symlinked, so editing `~/.config/nvim/init.lua` edits `dotfiles/nvim/init.lua` directly.

To add a new Neovim plugin, create `nvim/lua/plugins/<name>.lua` returning a lazy spec. lazy.nvim picks it up automatically on next launch.

To update `.p10k.zsh` after running `p10k configure`, the regenerated `~/.p10k.zsh` is already the symlink target — just `git add` and commit it.
