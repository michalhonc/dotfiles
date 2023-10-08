-- Set the plugin directory
vim.fn.stdpath('data') .. '/site/plugged'

-- Define the plugin manager function
local Plug = vim.fn['plug#']

-- Automatically install Plug.vim if not installed
if vim.fn.empty(vim.fn.glob('~/.vim/autoload/plug.vim')) then
  vim.fn.system({
    'curl',
    '-fLo',
    '~/.vim/autoload/plug.vim',
    '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  vim.cmd 'autocmd VimEnter * PlugInstall --sync | source $MYVIMRC'
end

-- Specify the plugin section
vim.cmd 'call plug#begin(stdpath("data") . "/site/plugged")'

-- GitHub Copilot (Example with a commented-out plugin)
-- Plug 'github/copilot.vim', {'branch': 'release'}

-- Linters & Type Checkers
-- Languages
Plug 'dense-analysis/ale'
Plug 'jason0x43/vim-js-indent'
Plug 'Quramy/vim-js-pretty-template'
Plug 'andrewradev/splitjoin.vim'
-- Plug 'mxw/vim-jsx'
Plug 'jparise/vim-graphql'
Plug 'pantharshit00/vim-prisma'
-- Plug 'sheerun/vim-polyglot'
Plug 'tomlion/vim-solidity'
Plug 'ryanolsonx/vim-xit'

-- Svelte
Plug 'evanleck/vim-svelte', {'branch': 'main'}

-- Find
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

-- Config
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'

-- Files
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

-- Visuals
-- Plug 'crusoexia/vim-monokai' (Modified config is in /nvim/colors)
Plug 'cormacrelf/vim-colors-github'

-- Git
Plug 'tpope/vim-fugitive'

-- End the plugin section
vim.cmd 'call plug#end()'

-- Highlight non-ASCII characters with a red background in GUI and a standout effect in the terminal
vim.cmd 'highlight nonascii guibg=Red ctermbg=1 term=standout'
vim.cmd 'autocmd BufReadPost * syntax match nonascii "[^\\u0000-\\u007F]"'

-- NERDTree configuration
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1
vim.g.NERDTreeWinPos = "right"
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDTreeChDirMode = 2
vim.g.NERDTreeShowHidden = 1

-- Automatically open NERDTree if no arguments and not in standard input mode
vim.cmd 'autocmd StdinReadPre * let s:std_in=1'
vim.cmd 'autocmd VimEnter * if argc() == 0 and not exists("s:std_in") | NERDTree | endif'

-- Close NERDTree if it's the only tab
vim.cmd 'autocmd BufEnter * if winnr("$") == 1 and exists("b:NERDTreeType") and b:NERDTreeType == "primary" | q | endif'

-- Map <C-e> to open NERDTreeFind
vim.api.nvim_set_keymap('n', '<C-e>', ':NERDTreeFind<CR>', { noremap = true, silent = true })

-- NERDCommenter configuration
vim.g.NERDSpaceDelims = 1
vim.g.NERDCompactSexyComs = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDToggleCheckAllLines = 1

-- Key mappings for NERDCommenterToggle
vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>NERDCommenterToggle', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true })

-- nvim-treesitter configuration for context_commentstring
require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true,
    commentary_integration = {
      Commentary = 'g/', -- Change default mapping
      CommentaryLine = false, -- Disable default mapping
    },
  }
}

-- Git
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}

-- Behaviors
vim.wo.cursorline = false
vim.o.errorbells = false
vim.o.visualbell = true

-- Show line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Don't wrap lines
-- vim.wo.wrap = false
-- vim.o.linebreak = true

vim.bo.re = 0

-- Enable yanking to the clipboard
vim.o.clipboard = 'unnamed'
-- vim.o.clipboard = 'unnamedplus'  -- Use the clipboards of vim and system
vim.o.paste = true               -- Paste from system clipboard
vim.o.go = vim.o.go .. 'a'       -- Visual selection automatically copied to the clipboard

-- Do not show -- INSERT--
vim.o.showmode = false

-- Split windows to the right and below natively
vim.o.splitright = true
vim.o.splitbelow = true

-- Mapleader (SPACE)
vim.g.mapleader = ' '

-- Searching
-- Highlight search matches
vim.o.hlsearch = true

-- Ignore node_modules with Command-T
vim.g.CommandTWildIgnore = vim.fn.wildignore() .. ',*/node_modules'

-- Ignore node_modules and build with CtrlP
vim.g.ctrlp_custom_ignore = 'node_modules\\|build'

-- Syntax
-- Intellisense
-- vim.o.omnifunc = 'syntaxcomplete#Complete'  -- Commented out as it is no longer needed
vim.g.qf_modifiable = 1
vim.g.jsx_ext_required = 0
vim.g.javascript_plugin_flow = 1

-- Terminal colors
vim.o.t_Co = 256  -- vim-monokai now only supports 256 colors in terminal

-- Lightline configuration
vim.g.lightline = {
  colorscheme = 'michalhonc',
  component_expand = {
    linter_checking = 'lightline#ale#checking',
    linter_warnings = 'lightline#ale#warnings',
    linter_errors = 'lightline#ale#errors',
    linter_ok = 'lightline#ale#ok',
  },
  component_type = {
    linter_checking = 'left',
    linter_warnings = 'warning',
    linter_errors = 'error',
    linter_ok = 'left',
  },
  component_function = {
    gitbranch = 'fugitive#head',
  },
  active = {
    left = {
      { 'mode', 'gitbranch', 'readonly', 'filename', 'modified' },
    },
    right = {
      { 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' },
    },
  },
}

-- ALE configuration
vim.cmd 'autocmd FileType qf setlocal wrap'

vim.g.ale_linters = {
  javascript = {'eslint'},
  typescript = {'eslint', 'tsserver', 'typecheck'},
  typescriptreact = {'eslint', 'tsserver', 'typecheck'},
}
vim.g.ale_fixers = {'prettier'}
-- vim.g.ale_fix_on_save = 1

vim.g.ale_open_list = 0
-- vim.g.ale_echo_cursor = 0
-- vim.g.ale_cursor_detail = 1
vim.g.ale_set_highlights = 0
-- vim.g.ale_list_window_size = 5
vim.g.ale_set_loclist = 1
vim.g.ale_set_quickfix = 1

-- Set this if you want to.
-- This can be useful if you are combining ALE with
-- some other plugin which sets quickfix errors, etc.
vim.g.ale_keep_list_window_open = 0
vim.g.ale_sign_warning = '>'
vim.g.netrw_winsize = 30

-- Set this in your vimrc file to disable highlighting
vim.g.ale_linters_ignore = {
  javascript = {'tsserver'},
  javascriptreact = {'tsserver'},
  typescriptreact = {'tsserver'},
}

vim.o.shortmess = 'at'
vim.o.cmdheight = 1

vim.cmd('colorscheme monokai')

-- Mapping to accept Copilot suggestions with <C-m>
vim.api.nvim_set_keymap('n', '<expr> <C-m>', "copilot#Accept('<CR>')", { noremap = true })

-- Disable Copilot mappings in tab-completion
vim.g.copilot_no_tab_map = true

-- Set the status line to always be visible
vim.o.laststatus = 2

-- Enable filetype detection, plugins, and indentation
vim.cmd('filetype plugin indent on')

-- Set tabstop, shiftwidth, and enable expandtab for consistent indentation
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

-- Disable line numbers
vim.wo.number = false

-- FZF file fuzzy search that respects .gitignore
-- If in a git directory, show only files that are committed, staged, or unstaged, else use regular :Files
vim.api.nvim_set_keymap('n', '<expr> <C-p>', 'len(system("git rev-parse --show-toplevel 2> /dev/null")) ? ":Files" : ":GFiles --exclude-standard --others --cached"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('n', '<expr> <C-[>', ':Files %:p:h', { noremap = true, silent = true, expr = true })

-- Move lines up and down with Alt-j and Alt-k
vim.api.nvim_set_keymap('n', '<Esc>j', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc>k', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Esc>j', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Esc>k', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<Esc>j', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<Esc>k', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })

-- Fuzzy search with Ag
vim.api.nvim_set_keymap('n', '<C-F>', ':Ag<Space>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-F>', ':Rg<Space>', { noremap = true, silent = true }) -- Uncomment this line if you prefer Ripgrep (Rg) over Silver Searcher (Ag)
vim.g.rg_highlight = 'true'

-- Go to definition with gd
vim.api.nvim_set_keymap('n', 'gd', ':ALEGoToDefinition<CR>', { noremap = true, silent = true })
-- AutoFix with F2
vim.api.nvim_set_keymap('n', '<F2>', ':ALEFix<CR>', { noremap = true, silent = true })

-- Meta-click (command-click) to go to definition
vim.api.nvim_set_keymap('n', '<M-LeftMouse>', '<LeftMouse>:ALEGoToDefinition<CR>', { noremap = true, silent = true })

-- Easy motion with 's'
vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-s2)', { noremap = true, silent = true })

-- Copy relative path with F4
vim.api.nvim_set_keymap('n', '<F4>', ':let @+=expand("%")<CR>', { noremap = true, silent = true })

-- Save with space leader key
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':ALEFix<CR>', { noremap = true, silent = true })

-- Disable arrow keys
vim.api.nvim_set_keymap('n', '<Up>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<NOP>', { noremap = true, silent = true })

-- Disable new line with Enter
vim.api.nvim_set_keymap('n', '<Enter>', '<NOP>', { noremap = true, silent = true })

-- Add a new line below with <NL> and Enter
vim.api.nvim_set_keymap('n', '<NL><Enter>', 'o<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Enter>', 'O<Esc>', { noremap = true, silent = true })

-- Show syntax stack for the current cursor position with F1
vim.api.nvim_set_keymap('n', '<F1>', ':echo join(reverse(map(synstack(line("."), col(".")), "synIDattr(v:val, 'name')")), ' ')<CR>', { noremap = true, silent = true })

-- Update commentstring with <leader>c
vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua require("ts_context_commentstring.internal").update_commentstring()<cr>', { noremap = true, silent = true })
