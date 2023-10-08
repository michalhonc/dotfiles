require("michalhonc.plugins.nvim-tree")
require("michalhonc.plugins.ale")
require("michalhonc.plugins.lightline")
require("michalhonc.plugins.fzf")

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

-- vim.bo.re = 0

-- Enable yanking to the clipboard
vim.o.clipboard = 'unnamed'
-- vim.o.clipboard = 'unnamedplus'  -- Use the clipboards of vim and system
vim.o.paste = true               -- Paste from system clipboard
-- vim.o.go = vim.o.go .. 'a'       -- Visual selection automatically copied to the clipboard

-- Do not show -- INSERT--
vim.o.showmode = false

-- Split windows to the right and below natively
vim.o.splitright = true
vim.o.splitbelow = true


-- Searching
-- Highlight search matches
vim.o.hlsearch = true

-- Ignore node_modules with Command-T
-- vim.g.CommandTWildIgnore = vim.fn.wildignore() .. ',*/node_modules'

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
