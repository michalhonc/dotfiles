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
vim.api.nvim_set_keymap('n', '<F1>', ':echo join(reverse(map(synstack(line("."), col(".")), "synIDattr(v:val, "name")")), " ")<CR>', { noremap = true, silent = true })

-- Update commentstring with <leader>c
vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua require("ts_context_commentstring.internal").update_commentstring()<cr>', { noremap = true, silent = true })