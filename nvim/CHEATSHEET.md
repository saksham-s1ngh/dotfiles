# Neovim Keymaps Cheatsheet

---

## Neo-tree — File Explorer

**Inside the neo-tree panel:**

| Key | Action |
|---|---|
| `Enter` | Open file / expand folder |
| `a` | Add file or directory (end with `/` for dir) |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy |
| `x` | Cut |
| `p` | Paste |
| `q` | Close panel |

---

## Telescope — Fuzzy Finder

**Inside any Telescope picker:**

| Key | Action |
|---|---|
| `↑ / ↓` or `Ctrl-p / Ctrl-n` | Move through results |
| `Enter` | Open selected |
| `Ctrl-v` | Open in vertical split |
| `Ctrl-x` | Open in horizontal split |
| `Esc` | Close |

**Search operators (type these as part of your query):**

| Prefix | Behaviour | Example |
|---|---|---|
| `'` | Exact substring match | `'Usings.cs` |
| `^` | Must start with | `^Usings` |
| `$` | Must end with | `.cs$` |
| `!` | Exclude matches | `!test` |

---

## LSP — Code Intelligence
*These only activate in files where a language server is running.*

| Key | Action |
|---|---|
| `K` | Hover — show docs/type signature for symbol under cursor |
| `gd` | Go to definition |
| `Ctrl-w d` | Show diagnostic detail for item under cursor |
| `]d` | Jump to next diagnostic |
| `[d` | Jump to previous diagnostic |

---

## Formatting & Linting

Formatting runs **automatically on save** for all configured filetypes.
Linting runs automatically on save for JS/TS (eslint_d) and Python (ruff).

---

## Autocompletion

| Key | Context | Action |
|---|---|---|
| `Tab` | Dropdown open | Select next item |
| `Shift-Tab` | Dropdown open | Select previous item |
| `Tab` | Inside snippet | Jump to next tab stop |
| `Shift-Tab` | Inside snippet | Jump to previous tab stop |
| `Enter` | Dropdown open | Confirm selection / expand snippet |
| `Ctrl-e` | Dropdown open | Dismiss / abort |
| `Ctrl-f` | Docs panel visible | Scroll docs down |
| `Ctrl-b` | Docs panel visible | Scroll docs up |

---

## File Info

| Key | Action |
|---|---|
| `Ctrl-g` | Show current file's relative path and line count |
| `1 Ctrl-g` | Show current file's full absolute path |

---

## Navigation

| Key | Action |
|---|---|
| `Ctrl-6` | Toggle between the two most recent files — instant "go back" |
| `Ctrl-o` | Step backward through jump history (works across files) |
| `Ctrl-i` | Step forward through jump history |

> Jump history records significant positions: every `gd`, file open, or large cursor jump. `Ctrl-o` / `Ctrl-i` walks that trail.

---

## Window Splits

| Key | Action |
|---|---|
| `Ctrl-w v` | Open vertical split (side by side) |
| `Ctrl-w s` | Open horizontal split (top and bottom) |
| `Ctrl-w c` | Close current split |
| `Ctrl-w o` | Close all splits except the current one |
| `Ctrl-w h/l/j/k` | Move focus left / right / down / up |
