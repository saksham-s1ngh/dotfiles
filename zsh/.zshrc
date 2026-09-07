# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git vi-mode zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="eza --icons"
alias python=python3

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Enable vi mode and remove Esc delay
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for vi modes
function zle-keymap-select {
      if [[ $KEYMAP == vicmd ]]; then
              printf '\e[1 q' # Blinking block for Normal mode
      else
              printf '\e[5 q' # Blinking line for Insert mode
      fi
}
zle -N zle-keymap-select

# Ensure cursor is a line when starting a new prompt
zle-line-init() {
      zle -K viins
      printf '\e[5 q'
}
zle -N zle-line-init

# Accept autosuggestions using Ctrl + f in both Vi modes
bindkey -M viins '^f' autosuggest-accept
bindkey -M vicmd '^f' autosuggest-accept

export PATH="$HOME/.local/bin:$PATH"
