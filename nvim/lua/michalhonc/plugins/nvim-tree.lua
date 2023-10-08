-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = false

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    on_attach = my_on_attach,
    view = {
        width = 40,
        side = "right"
    },
    update_focused_file = {
        enable = true
    },
    system_open = {
        cmd = "open"
    },
    renderer = {
        group_empty = false,
        icons = {
            show = {
                file = false,
                folder = true,
                folder_arrow = true,
                git = false,
                modified = false,
                diagnostics = false,
                bookmarks = false
            },
            glyphs = {
                folder = {
                    arrow_closed = "▸",
                    arrow_open = "▾",
                    empty = "🚮",
                    empty_open = "🚮",
                    default = "",
                    open = ""
                }
            },
            web_devicons = {
                file = {
                    enable = false,
                    color = false
                },
                folder = {
                    enable = false,
                    color = false
                }
            }
        }
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false
            }
        }
    },
    filters = {
        dotfiles = true
    },
    git = {
        enable = false
    }
})

