# dotfiles

Personal config for Neovim, Ghostty, and Zsh — optimised for macOS on Apple Silicon.

## What's included

| Config         | Repo path        | Symlinked to         |
| -------------- | ---------------- | -------------------- |
| Neovim         | `nvim/`          | `~/.config/nvim/`    |
| Ghostty        | `ghostty/`       | `~/.config/ghostty/` |
| Zsh            | `zsh/.zshrc`     | `~/.zshrc`           |
| Powerlevel10k  | `zsh/.p10k.zsh`  | `~/.p10k.zsh`        |
| Git (portable) | `git/.gitconfig` | Included from `~/.gitconfig` (not symlinked) |

---

## Setting up on a new machine

### 1. Install Xcode Command Line Tools

Required before anything else — Git, curl, and the C compiler live here.

```bash
xcode-select --install
```

Confirm it worked:

```bash
git --version
```

### 2. Clone the repo

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
```

> If you haven't pushed to GitHub yet, copy the folder to the new machine manually and skip the clone.

### 3. Run the install script

```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The script handles everything that can be automated:

- Installs **Homebrew** (if missing)
- Installs **Neovim** and **eza** via Homebrew
- Installs **Oh My Zsh** (if missing)
- Clones **Powerlevel10k** and the zsh plugins (`zsh-syntax-highlighting`, `zsh-autosuggestions`)
- Backs up any existing `~/.config/nvim`, `~/.config/ghostty`, and `~/.gitconfig` to `.bak` versions
- Symlinks nvim, Ghostty, and zsh configs to their correct locations
- Creates `~/.gitconfig` as a real, untracked file that includes `git/.gitconfig` — kept separate so identity never ends up in the repo

### 4. Set your Git identity

`git/.gitconfig` stores only portable settings — name and email are intentionally omitted. `install.sh` creates `~/.gitconfig` as a real file (not a symlink) that includes this repo's config, so identity set here stays local to your machine and never gets committed.

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### 5. Open a new terminal session

Close and reopen your terminal (or `source ~/.zshrc`). The Powerlevel10k prompt should appear immediately because `.p10k.zsh` is included in the repo.

### 6. First-time Neovim setup

```bash
nvim
```

[lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself and installs all plugins automatically. Wait for the progress UI to finish, then quit and reopen:

```
:q
nvim
```

LSP servers declared in `nvim/lua/plugins/lsp.lua` are installed automatically by Mason on first launch. You can check status with `:Mason`.

### 7. Install formatters and linters (inside Neovim)

**Always install:**

```
:MasonInstall stylua prettier eslint_d ruff
```

- `stylua` — Lua formatter
- `prettier` — JS / TS / HTML / CSS / JSON / YAML / Markdown
- `eslint_d` — fast ESLint daemon for JS/TS linting
- `ruff` — Python linter

**For Python formatting** (run in terminal first):

```bash
brew install python
```

Then inside Neovim:

```
:MasonInstall black isort
```

**For C# / .NET** (optional - skip unless you're working in C#; run in terminal first):

```bash
brew install --cask dotnet-sdk
```

Then inside Neovim:

```
:MasonInstall csharpier
```

### 8. Verify everything is working

| Check                 | Command                                                      |
| --------------------- | ------------------------------------------------------------ |
| Zsh theme loads       | Open a new terminal — prompt should show Powerlevel10k style |
| `ls` shows icons      | `ls` (uses `eza --icons` alias)                              |
| Neovim plugins loaded | `nvim` → `:Lazy` — all plugins should be green               |
| LSP active            | Open any `.lua` file → `K` should show hover docs            |
| Formatter working     | Open any `.lua` file → `Space gf` formats on demand          |
| File explorer         | `nvim` → `Space e` toggles Neo-tree                          |
| Fuzzy finder          | `nvim` → `Space ff` opens Telescope                          |

---

## Keeping dotfiles in sync

Because nvim, Ghostty, and zsh configs are symlinked, edits made in `~/.config/nvim`, `~/.config/ghostty`, or `~/.zshrc` are immediately reflected in this repo. `~/.gitconfig` is the exception — it's a real local file, so to change portable git settings, edit `git/.gitconfig` in this repo directly. To save changes:

```bash
cd ~/dotfiles
git add .
git commit -m "update config"
git push
```

On any other machine, pull the latest:

```bash
cd ~/dotfiles
git pull
```

No re-running `install.sh` needed — the symlinks already point at the updated files.

---

## Tips

**Neovim**

- Cheatsheet: open `nvim/CHEATSHEET.md` or `Space ff` → type `CHEATSHEET`
- Add a plugin: create `nvim/lua/plugins/<name>.lua` returning a lazy spec table — picked up automatically
- Add an LSP server: add the Mason name to `ensure_installed` in `nvim/lua/plugins/lsp.lua`
- Add a formatter: add an entry to `formatters_by_ft` in `nvim/lua/plugins/conform.lua`
- Add a language to Treesitter: add it to `ensure_installed` in `nvim/lua/plugins/treesitter.lua`
- Rust LSP: requires rustup — `brew install rustup && rustup-init`, then uncomment `rust_analyzer` in `lsp.lua`
- Go support: `brew install go`, then add `"gopls"` to `lsp.lua` and `go = { "gofmt" }` to `conform.lua`

**Ghostty**

- Browse themes: `ghostty +list-themes`
- Change theme: edit `ghostty/config` → `theme = <ThemeName>`
- Current theme: Catppuccin Mocha

**Zsh**

- Reconfigure the prompt: `p10k configure`
- Active plugins: `git`, `vi-mode`, `zsh-syntax-highlighting`, `zsh-autosuggestions`
- `vim` is aliased to `nvim`
- `ls` is aliased to `eza --icons`
