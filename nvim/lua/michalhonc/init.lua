require("michalhonc.packer") 
require("michalhonc.mappings")
require("michalhonc.config")
require("michalhonc.plugins")

-- Highlight non-ASCII characters with a red background in GUI and a standout effect in the terminal
vim.cmd 'highlight nonascii guibg=Red ctermbg=1 term=standout'
vim.cmd 'autocmd BufReadPost * syntax match nonascii "[^\\u0000-\\u007F]"'

-- Set tabstop, shiftwidth, and enable expandtab for consistent indentation
vim.cmd 'set shiftwidth=2'
vim.cmd 'set tabstop=2'
vim.cmd 'set expandtab'
vim.cmd 'set autoindent'
-- vim.cmd 'set smartindent'
vim.cmd 'set list'
vim.cmd 'set listchars=tab:>-'
vim.cmd 'filetype plugin indent on'


--[[
-- NERDCommenter configuration
vim.g.NERDSpaceDelims = 1
vim.g.NERDCompactSexyComs = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDToggleCheckAllLines = 1
--]]

--[[
-- Key mappings for NERDCommenterToggle
vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>NERDCommenterToggle', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv', { noremap = true })


 --]]
