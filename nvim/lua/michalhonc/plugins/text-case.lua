-- Function to create Lua mappings for text case conversions
local function create_textcase_mapping(from, to)
    vim.api.nvim_set_keymap('n', from, [[:lua require('textcase').current_word(']] .. to .. [[')<CR>]], { noremap = true, silent = true })
end

-- Function to create Lua mappings for LSP-based text case conversions
local function create_lsp_textcase_mapping(from, to)
    vim.api.nvim_set_keymap('n', from, [[:lua require('textcase').lsp_rename(']] .. to .. [[')<CR>]], { noremap = true, silent = true })
end

-- Define the mappings
create_textcase_mapping('gau', 'to_upper_case')
create_textcase_mapping('gal', 'to_lower_case')
create_textcase_mapping('gas', 'to_snake_case')
create_textcase_mapping('gad', 'to_dash_case')
create_textcase_mapping('gan', 'to_constant_case')
create_textcase_mapping('gad', 'to_dot_case')
create_textcase_mapping('gaa', 'to_phrase_case')
create_textcase_mapping('gac', 'to_camel_case')
create_textcase_mapping('gap', 'to_pascal_case')
create_textcase_mapping('gat', 'to_title_case')
create_textcase_mapping('gaf', 'to_path_case')

create_lsp_textcase_mapping('gaU', 'to_upper_case')
create_lsp_textcase_mapping('gaL', 'to_lower_case')
create_lsp_textcase_mapping('gaS', 'to_snake_case')
create_lsp_textcase_mapping('gaD', 'to_dash_case')
create_lsp_textcase_mapping('gaN', 'to_constant_case')
create_lsp_textcase_mapping('gaD', 'to_dot_case')
create_lsp_textcase_mapping('gaA', 'to_phrase_case')
create_lsp_textcase_mapping('gaC', 'to_camel_case')
create_lsp_textcase_mapping('gaP', 'to_pascal_case')
create_lsp_textcase_mapping('gaT', 'to_title_case')
create_lsp_textcase_mapping('gaF', 'to_path_case')
