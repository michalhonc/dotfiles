-- Rex config

-- Worktrees (all repos): https://github.com/haxybaxy/rex-worktrunk
require("rex-worktrunk").setup{
  base   = "^",      -- new branches start from the repo's default branch
  group  = "session", -- one sidebar entry (session) per worktree
  picker = "native", -- Rex command palette instead of fzf
  runner = "tab",    -- local patch: create/remove in a background tab, not a float
}
