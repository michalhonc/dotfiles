require("michalhonc")

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