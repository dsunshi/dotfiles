-- Function to map keys
local map = vim.api.nvim_set_keymap
-- noremap is definitly a safe bet here
local default_opts = {noremap = true}

-- Transparency
map("n", "<leader>tt", "<cmd>TransparentToggle<cr>", default_opts)

-- markdown preview
map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", default_opts)

-- specify browser to open preview page
-- default: ''
-- This script will force qutebrowser to open a new window for the preview
vim.g.mkdp_browser = 'mdbrowser'

-- telescope settings
-- ==================

-- Search hidden folders, but not .git
map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)

map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", default_opts)
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",   default_opts)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", default_opts)
map('n', '<leader>gs', "<cmd>lua require'telescope.builtin'.git_status()<cr>",  default_opts)


-- xclip system copy/paste
map('v', '<leader>y', ":w !xclip<cr><cr>",  default_opts)
map('n', '<leader>p', ":r!xclip -o<cr>",  default_opts)
