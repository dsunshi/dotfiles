
-- =============================================================================
-- Plugins {{{1
-- =============================================================================
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Have Packer manage itself
    use { 'wbthomason/packer.nvim', opt = true }

    -- Searching
    -- =========================================================================
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Appearance
    -- =========================================================================
    use 'EdenEast/nightfox.nvim'         -- Color scheme
    use 'xiyaowong/nvim-transparent'     -- Transparency enable/disable
    use 'norcalli/nvim-colorizer.lua'    -- Display colors in Vim

    -- Notes
    -- =========================================================================
    -- use {
    --     'vimwiki/vimwiki',
    --     -- vimwiki config: nvim/lua/config/wiki.lua
    --     config = function() require("config.wiki") end
    -- }
    -- use 'tbabej/taskwiki'   -- TaskWarrior integration
    -- Rust
    -- =========================================================================
    use 'rust-lang/rust.vim'
    -- Extra rust analyzer functionality
    use 'simrat39/rust-tools.nvim'

    -- Markdown
    -- =========================================================================
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = {'markdown'}
    }

    -- Code Editing (IDE)
    -- =========================================================================
    -- Code commenting
    use {
        'numToStr/Comment.nvim',
        config = function()
           require('Comment').setup()
        end
    }
    use 'tpope/vim-fugitive'                           -- Git integration
    use 'plasticboy/vim-markdown'                      -- Markdown support
    use 'tpope/vim-surround'                           -- Change text surrounds
    use 'junegunn/fzf.vim'                             -- Fuzzy searching
    use 'justinmk/vim-sneak'                           -- Text search

    use 'nvim-treesitter/nvim-treesitter'              -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects'  -- Additional textobjects for treesitter


    -- LSP/Autocomplete + Snippets
    -- =========================================================================
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'}
        },
        -- cmp config: nvim/lua/config/cmp.lua
        config = function() require("config.cmp") end
    }
    use { 'saadparwaiz1/cmp_luasnip' }
    use {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
    }
    use 'nvim-lua/lsp_extensions.nvim'  -- Collection of configurations for built-in LSP client
    -- Extensions to built-in LSP, for example, providing type inlay hints
    use {
        'neovim/nvim-lspconfig',
        -- lsp config: nvim/lua/config/lsp.lua
        config = function() require("config.lsp") end
    }
    -- Status line
    -- =========================================================================
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
end)

-- =============================================================================
-- Colorscheme {{{1
-- =============================================================================
-- require('nightfox').load('duskfox')
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/duskfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,    -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = true,   -- Non focused panes set to alternative background
    styles = {              -- Style to be applied to different syntax groups
      comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  }
})

-- setup must be called before loading
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd("colorscheme nightfox")
require('lualine').setup {
  options = {
    theme = 'nightfox'
  }
}

-- =============================================================================
-- Options {{{1
-- =============================================================================
-- Make sure the updated leader mapping is done early
vim.g.mapleader = ' '           -- Map leader to space

-- editor settings: nvim/lua/editor.lua
require('editor')

-- gui settings: nvim/lua/gui.lua
require('gui')

-- key mappings: nvim/lua/keymap.lua
require('keymap')

-- Disable folding in markdown since it is more of a pain than anything
vim.g.vim_markdown_folding_disabled = 1

require('rust-tools').setup(opts)
vim.g.rustfmt_autosave = true   -- Format rust code when the buffer is saved

-- Automatic, language-dependent indentation, syntax coloring and other
-- functionality.
--
-- Must come *after* the `:packadd!` calls above otherwise the contents of
-- package "ftdetect" directories won't be evaluated.
vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')

require("transparent").setup({
  enable = false,  -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be clear
    -- In particular, when you set it to 'all', that means all avaliable groups

    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude = {}, -- table: groups you don't want to clear
})
