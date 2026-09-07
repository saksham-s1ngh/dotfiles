#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "→ Starting dotfiles setup..."

# ── Homebrew ────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "→ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── Core tools ──────────────────────────────────────────────────────────────
echo "→ Installing core tools..."
brew install neovim eza

# ── Oh My Zsh ───────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "→ Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── Zsh plugins & theme ─────────────────────────────────────────────────────
echo "→ Installing Powerlevel10k and zsh plugins..."

[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ] && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ] && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

# ── Symlink configs ──────────────────────────────────────────────────────────
echo "→ Symlinking configs..."
mkdir -p "$HOME/.config"

# Back up existing configs if they're real directories or files (not already symlinks)
for dir in nvim ghostty; do
  target="$HOME/.config/$dir"
  if [ -d "$target" ] && [ ! -L "$target" ]; then
    echo "  Backing up $target to $target.bak"
    mv "$target" "$target.bak"
  fi
done

ln -sf "$DOTFILES_DIR/nvim"              "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/ghostty"           "$HOME/.config/ghostty"

for f in .zshrc .p10k.zsh; do
  if [ -f "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
    echo "  Backing up ~/$f to ~/$f.bak"
    mv "$HOME/$f" "$HOME/$f.bak"
  fi
done
ln -sf "$DOTFILES_DIR/zsh/.zshrc"        "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/.p10k.zsh"     "$HOME/.p10k.zsh"

# .gitconfig is NOT symlinked — it stays a real, untracked file per machine
# so personal identity never lands in the repo. It just includes the
# portable settings from the repo.
if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
  echo "  Backing up ~/.gitconfig to ~/.gitconfig.bak"
  mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
elif [ -L "$HOME/.gitconfig" ]; then
  rm "$HOME/.gitconfig"
fi

if [ ! -f "$HOME/.gitconfig" ]; then
  cat > "$HOME/.gitconfig" <<GITCFG
[include]
      path = $DOTFILES_DIR/git/.gitconfig
GITCFG
fi

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo "✓ Done! Manual steps still required:"
echo ""
echo "  1. Set your git identity (not stored in dotfiles):"
echo "       git config --global user.name \"Your Name\""
echo "       git config --global user.email \"you@example.com\""
echo ""
echo "  2. Open a new terminal — the Powerlevel10k prompt should appear immediately."
echo "     If it doesn't, run: source ~/.zshrc"
echo ""
echo "  3. Open Neovim — lazy.nvim will auto-install all plugins:"
echo "       nvim"
echo "     Wait for the install UI to finish, then :q and reopen."
echo ""
echo "  4. Inside Neovim, install formatters and linters:"
echo "       :MasonInstall stylua prettier eslint_d ruff"
echo ""
echo "  5. (Optional, skip if not using C#) For C# support (requires dotnet-sdk first):"
echo "       brew install --cask dotnet-sdk"
echo "       # then inside nvim:"
echo "       :MasonInstall csharpier"
echo ""
echo "  6. For Python formatters (requires Homebrew Python first):"
echo "       brew install python"
echo "       # then inside nvim:"
echo "       :MasonInstall black isort"
