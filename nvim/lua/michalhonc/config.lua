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