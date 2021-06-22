
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- have Packer manage itself
    use { 'wbthomason/packer.nvim', opt = true }


    -- colorscheme
    use 'marko-cerovac/material.nvim'

    -- status line
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }


end)

-- colorscheme
require('material').set()
require('lualine').setup {
  options = {
    theme = 'nord'
  }
}
vim.g.material_style = "deep ocean"





-- Map leader to space
vim.g.mapleader = ' '

-- vim.o sets global options, e.g.: vim.o.hidden
-- vim.bo sets only buffer-scoped options, e.g.: vim.bo.expandtab = true
-- vim.wo sets only window-scoped options, e.g.: vim.wo.number = true

-- This method of setting the scope is a temporary work-around until this PR is merged:
-- https://github.com/neovim/neovim/pull/13479

-- Help with setting up scops, stolen from: https://github.com/shaunsingh/vimrc-dotfiles/blob/main/.config/nvim/init.lua
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  -- This line is the workaround
  if scope ~= 'o' then scopes['o'][key] = value end
end


opt('o', 'relativenumber', true)
