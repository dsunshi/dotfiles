-- =============================================================================
-- GUI
--
-- This file configures the way vim looks when editing
-- =============================================================================
local opt = vim.opt

opt.guifont       = 'JetBrainsMono NF:h16'    -- Patched version from https://www.nerdfonts.com/#home
opt.belloff       = 'all'                     -- Never ring the bell for any reason
opt.splitbelow    = true                      -- Open horizontal splits below current window
opt.splitright    = true                      -- Open vertical splits to the right of the current window

require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  rust = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in rust.
}
