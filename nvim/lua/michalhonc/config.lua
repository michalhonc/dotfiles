vim.o.shortmess = 'at'
vim.o.cmdheight = 1

vim.cmd('colorscheme monokai')

-- Set the status line to always be visible
vim.o.laststatus = 2


-- Set tabstop, shiftwidth, and enable expandtab for consistent indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Disable line numbers
vim.wo.number = false
