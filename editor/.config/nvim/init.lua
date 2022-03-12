
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
    use 'vimwiki/vimwiki'
    use 'tbabej/taskwiki'   -- TaskWarrior integration
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
            {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'},
            {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
            {'hrsh7th/cmp-path', after = 'nvim-cmp'},
            {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}
        },
        -- cmp config
        -- config = function() require("config.cmp") end
    }
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
        -- config = function() require('config.snippets') end,
    }
    use 'nvim-lua/lsp_extensions.nvim'  -- Extensions to built-in LSP, for example, providing type inlay hints
    use 'neovim/nvim-lspconfig'         -- Collection of configurations for built-in LSP client

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
require('nightfox').load('duskfox')
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

-- editor settings
require('editor')
-- gui settings
require('gui')
-- key mappings
require('keymap')

-- vimwiki settings
-- ==================
vim.g.vimwiki_list = {
    {
        path = '~/.vimwiki',
        syntax = 'markdown',
        ext = '.md',
    }
}

-- Makes vimwiki use markdown links as [text](text.md) instead of [text](text)
vim.g.vimwiki_markdown_link_ext = 1
vim.g.taskwiki_markup_syntax = 'markdown'

vim.g.rustfmt_autosave = true   -- Format rust code when the buffer is saved

-- Disable folding in markdown since it is more of a pain than anything
vim.g.vim_markdown_folding_disabled = 1

-- nvim-cmp setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        local luasnip = require("luasnip")
        if not luasnip then
            return
        end
        luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<Tab>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if not luasnip then
          return
      end
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if not luasnip then
          return
      end
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
