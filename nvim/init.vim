call plug#begin('~/.config/nvim/plugged')

" --- Theming ---
Plug 'rebelot/kanagawa.nvim'       " Goldish-Black (Dragon)
Plug 'EdenEast/nightfox.nvim'      " Bluish-Black (Carbonfox)
Plug 'nvim-tree/nvim-web-devicons'

" --- UI Enhancements ---
Plug 'rcarriga/nvim-notify'        " Smooth notifications
Plug 'stevearc/dressing.nvim'      " Better UI for inputs/selects
Plug 'folke/noice.nvim'            " Premium Floating Command Bar
Plug 'MunifTanjim/nui.nvim'        " UI Component library
Plug 'nvim-lualine/lualine.nvim'   " Statusline
Plug 'akinsho/bufferline.nvim'     " Visual tabs
Plug 'nvimdev/dashboard-nvim'      " Pro start screen
Plug 'lukas-reineke/indent-blankline.nvim' " Indent lines
Plug 'j-hui/fidget.nvim'           " LSP progress
Plug 'lewis6991/gitsigns.nvim'     " Git decorations
Plug 'nvimdev/lspsaga.nvim'        " Floating docs and hover

" --- Core Tools & Editing ---
Plug 'nvim-tree/nvim-tree.lua'     " File Tree
Plug 'nvim-lua/plenary.nvim'       " Utils
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'numToStr/Comment.nvim'       " Commenting (gc)
Plug 'mg979/vim-visual-multi'      " Multi-cursors (Ctrl-n)
Plug 'tpope/vim-surround'          " Change surroundings

" --- Coding Intelligence ---
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'windwp/nvim-autopairs'

call plug#end()

"" --- System Settings ---
set number
set relativenumber
set signcolumn=yes
set cursorline
set termguicolors
set clipboard=unnamedplus
set mouse=a
set scrolloff=10
set fillchars=eob:\ 
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

"" --- Colorscheme Setup ---
let g:kanagawa_variant = "dragon"
silent! colorscheme kanagawa-dragon

"" --- UI Customization (Lua) ---
lua << EOF
local function safe_require(m)
    local ok, res = pcall(require, m)
    return ok and res or nil
end

-- Comment.nvim
local comment = safe_require("Comment")
if comment then comment.setup() end

-- Notify
local notify = safe_require("notify")
if notify then 
    vim.notify = notify 
    notify.setup({ background_colour = "#000000", render = "compact" })
end

-- Noice (ULTRA STABLE: NO TREESITTER)
local noice = safe_require("noice")
if noice then
    noice.setup({
        cmdline = {
            enabled = true,
            view = "cmdline_popup", 
            format = {
                -- DISABLE 'lang = "vim"' to stop it from trying to highlight with TS
                cmdline = { pattern = "^:", icon = "", lang = "" },
            },
        },
        messages = { enabled = true, view = "notify" },
        popupmenu = { enabled = true, backend = "nui" },
        lsp = {
            progress = { enabled = false },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                ["vim.lsp.util.stylize_markdown"] = false,
                ["cmp.entry.get_documentation"] = false,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            lsp_doc_border = true,
        },
    })
end

-- Lspsaga
local saga = safe_require("lspsaga")
if saga then saga.setup({ symbol_in_winbar = { enable = false }, lightbulb = { enable = false } }) end

-- Lualine
local lualine = safe_require('lualine')
if lualine then lualine.setup { options = { theme = 'kanagawa', globalstatus = true } } end

-- File Tree
local nvim_tree = safe_require("nvim-tree")
if nvim_tree then nvim_tree.setup() end

-- Treesitter (CRITICAL: vim is EXCLUDED here)
local ts_configs = safe_require('nvim-treesitter.configs')
if ts_configs then
    pcall(function()
        ts_configs.setup {
          ensure_installed = { "python", "lua", "bash", "javascript" },
          auto_install = true,
          highlight = { 
            enable = true,
            -- If vim highlighting is still causing issues, we block it here too
            disable = { "vim" },
          },
          indent = { enable = true }
        }
    end)
end

-- Autocompletion
local cmp = safe_require('cmp')
if cmp then
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      }),
      sources = { { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' } }
    })
end

-- Telescope Setup
local telescope = safe_require("telescope")
if telescope then
    telescope.setup({
        defaults = {
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 10,
        },
        pickers = {
            current_buffer_fuzzy_find = {
                theme = "dropdown",
                previewer = false,
            },
            live_grep = {
                theme = "dropdown",
            },
            grep_string = {
                theme = "dropdown",
            },
        },
    })
end

-- Extra Plugins
if safe_require("ibl") then require("ibl").setup { indent = { char = "│" }, scope = { enabled = false } } end
if safe_require("fidget") then require("fidget").setup() end
if safe_require("gitsigns") then require("gitsigns").setup() end
EOF

"" --- Mappings ---
let mapleader = " "
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({ search_dirs = { vim.fn.expand('%:p:h') } }))<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>fs <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" --- Multi-Line Indenting ---
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv
vnoremap < <gv
vnoremap > >gv

" Quick Commenting (Leader + /)
nmap <leader>/ gcc
vmap <leader>/ gc

" Saga mappings
nnoremap K <cmd>Lspsaga hover_doc<cr>
nnoremap <leader>ca <cmd>Lspsaga code_action<cr>
nnoremap <leader>rn <cmd>Lspsaga rename<cr>

" Clean UI
set cmdheight=0
