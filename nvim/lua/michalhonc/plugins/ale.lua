-- ALE configuration
vim.cmd 'autocmd FileType qf setlocal wrap'

vim.g.ale_linters = {
  javascript = {'eslint'},
  typescript = {'eslint', 'tsserver', 'typecheck'},
  typescriptreact = {'eslint', 'tsserver', 'typecheck'},
}
vim.g.ale_fixers = {'prettier'}

vim.g.ale_open_list = 0
vim.g.ale_set_highlights = 0
vim.g.ale_set_loclist = 1
vim.g.ale_set_quickfix = 1

-- Set this if you want to.
-- This can be useful if you are combining ALE with
-- some other plugin which sets quickfix errors, etc.
vim.g.ale_keep_list_window_open = 0
vim.g.ale_sign_warning = '>'
vim.g.netrw_winsize = 30

-- vim.g.ale_linters_ignore = {
--   javascript = {'tsserver'},
--   javascriptreact = {'tsserver'},
--   typescriptreact = {'tsserver'},
-- }
