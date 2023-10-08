-- Lightline configuration
vim.g.lightline = {
    -- colorscheme = 'michalhonc',
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