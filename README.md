# 🐉 High-Performance Neovim Config

This is a premium, modern Neovim setup designed for high-performance coding. It features a deep goldish-black and bluish-black aesthetic, advanced syntax highlighting, and a stable, floating command-line interface.

## ✨ Features

- **Theming**: Premium **Kanagawa-Dragon** (Goldish-Black) or **Carbonfox** (Bluish-Black).
- **UI Overhaul**: 
  - **Noice.nvim**: Centered floating command bar and modern notifications.
  - **Lspsaga.nvim**: Floating windows for hover docs, renaming, and code actions.
  - **Lualine & Bufferline**: Sleek statusline and visual tabs with file icons.
  - **Fidget.nvim**: Smooth floating progress bars for LSP indexing.
- **Editing Power**:
  - **Multi-cursor support** (`Ctrl+n`).
  - **Smart Commenting** (`gc`).
  - **IDE-style Indenting**: Use `Tab` and `Shift+Tab` to indent/outdent multiple lines at once.
  - **Git decorations**: Real-time git diffs in the margin.
  - **Vertical Indent Lines**: Tracking your code blocks with precision.
- **Tools**:
  - **Telescope**: Lightning-fast fuzzy search.
  - **nvim-tree**: Modern file tree with high-res icons.
  - **Treesitter**: Advanced syntax highlighting (auto-installs parsers).
  - **nvim-cmp**: Intelligent autocompletion with LSP support.

---

## 🚀 Installation

### 1. Requirements

Before installing, ensure your laptop has:

- **Neovim 0.10+** (Recommended: 0.11+).
- **Git**
- **Node.js & npm** (Required for LSPs and some plugins).
- **Python 3 & pip** (`pip install pynvim` is required for some plugins).
- **tree-sitter-cli** (v0.22.x recommended for stability with GLIBC).
- **A Nerd Font**: **REQUIRED** for icons. Download [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) and set it as your terminal font.

### 2. Setup

Run these commands to clone the config and install the plugin manager:

```bash
# Clone the repository
git clone https://github.com/hegdeadithyak/vimconfig.git ~/.config/nvim

# Install vim-plug (Plugin Manager)
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### 3. Install Plugins

1. Open Neovim: `nvim`
2. Run the install command: `:PlugInstall`
3. (Optional) Run `:TSUpdate` to refresh syntax parsers.

---

## ⌨️ Keybindings

| Key | Action |
|-----|--------|
| `Ctrl + n` | Toggle File Explorer (nvim-tree) |
| `Space + ff` | Find Files (Telescope) |
| `Space + fg` | Search Text (Live Grep) |
| `Tab` | Switch to Next Buffer |
| `Shift + Tab` | Switch to Previous Buffer |
| `K` | Hover Documentation (Lspsaga) |
| `Space + rn` | Rename Variable (Lspsaga) |
| `Space + ca` | Code Actions (Lspsaga) |
| `Tab` (Visual) | Indent Selection |
| `Shift + Tab` (Visual) | Outdent Selection |
| `gc` (Visual) | Comment Selection |
| `Ctrl + n` (Normal) | Start Multi-cursor |

---

## 🎨 Themes

To switch between the premium themes:

- **Goldish-Black**: `:colorscheme kanagawa-dragon`
- **Bluish-Black**: `:colorscheme carbonfox`
- **Purple-Dark**: `:colorscheme tokyonight-moon`

---

*Configured for a "fucking good" coding experience.* 🚀
