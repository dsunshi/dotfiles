
-- =============================================================================
-- Plugins {{{1
-- =============================================================================
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- have Packer manage itself
    use { 'wbthomason/packer.nvim', opt = true }

    use 'EdenEast/nightfox.nvim' -- colorscheme
    use 'xiyaowong/nvim-transparent' -- transparency enable/disable

    use 'rhysd/vim-clang-format'

    -- rust
    use 'rust-lang/rust.vim'

    use 'tomtom/tcomment_vim' -- code commenting
    use 'tpope/vim-fugitive' -- git integration
    use 'tommcdo/vim-lion' -- text alignment
    use 'plasticboy/vim-markdown' -- markdown support
    use 'kshenoy/vim-signature' -- place, toggle and display marks.
    use 'tpope/vim-surround' -- change text surrounds
    --use 'junegunn/goyo.vim' -- focused editing
    --use 'junegunn/limelight.vim' -- more focused editing
    use 'junegunn/fzf.vim' -- fuzzy searching
    use 'justinmk/vim-sneak' -- text search


    use 'nvim-treesitter/nvim-treesitter'  -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects'  -- Additional textobjects for treesitter

    -- lsp / autocomplete
    use 'nvim-lua/lsp_extensions.nvim' -- Extensions to built-in LSP, for example, providing type inlay hints
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- luasnip
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'saadparwaiz1/cmp_luasnip' -- cmp compatability

    -- status line
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
-- vim.g.material_style = "deep ocean"


-- =============================================================================
-- Editor {{{1
-- =============================================================================

local tabsize = 4

vim.opt.number         = true   -- show line numbers in gutter
vim.opt.relativenumber = true   -- show relative numbers in gutter
vim.opt.textwidth      = 80     -- automatically hard wrap at 80 columns
vim.opt.scrolloff      = 3      -- start scrolling 3 lines before edge of viewport
vim.opt.cursorline     = true   -- highlight current line
vim.opt.expandtab      = true   -- always use spaces instead of tabs
vim.opt.fillchars      = {
  diff                 = '∙',                              -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob                  = ' ',                              -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold                 = '·',                              -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert                 = '┃',                              -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}
vim.opt.formatoptions  = vim.opt.formatoptions + 'j'       -- remove comment leader when joining comment lines
vim.opt.formatoptions  = vim.opt.formatoptions + 'n'       -- smart auto-indenting inside numbered lists
vim.opt.laststatus     = 2                                 -- always show status line
vim.opt.lazyredraw     = true                              -- don't bother updating screen during macro playback
vim.opt.linebreak      = true                              -- wrap long lines at characters in 'breakat'
vim.opt.list           = true                              -- show whitespace
vim.opt.listchars      = {
  nbsp                 = '⦸',                              -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends              = '»',                              -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes             = '«',                              -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab                  = '▷⋯',                             -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  trail                = '•',                              -- BULLET (U+2022, UTF-8: E2 80 A2)
}
vim.opt.shiftwidth    = tabsize                       -- spaces per tab (when shifting)
vim.opt.tabstop       = tabsize                       -- spaces per tab
vim.opt.showbreak     = '↳ '                    -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
vim.opt.smarttab      = true                    -- <tab>/<BS> indent/dedent in leading whitespace

vim.opt.completeopt    = 'menuone,noinsert,noselect'
vim.opt.shortmess    = vim.opt.shortmess + 'c'

-- =============================================================================
-- GUI {{{1
-- =============================================================================

vim.opt.guifont        = 'JetBrainsMono NF:h16'            -- patched version from https://www.nerdfonts.com/#home
vim.opt.belloff        = 'all'                             -- never ring the bell for any reason
vim.opt.splitbelow    = true                    -- open horizontal splits below current window
vim.opt.splitright    = true                    -- open vertical splits to the right of the current window

-- =============================================================================
-- Options {{{1
-- =============================================================================

vim.g.mapleader = ' ' -- Map leader to space
vim.g.rustfmt_autosave  = true

-- Disable folding in markdown since it is more of a pain than anyghing
vim.g.vim_markdown_folding_disabled=1

local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Forward to other plugins
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- LSP and auto completion
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { "rust_analyzer" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}


-- Automatic, language-dependent indentation, syntax coloring and other
-- functionality.
--
-- Must come *after* the `:packadd!` calls above otherwise the contents of
-- package "ftdetect" directories won't be evaluated.
vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')

require("transparent").setup({
  enable = false, -- boolean: enable transparent
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


-- =============================================================================
-- Auto Commands {{{1
-- =============================================================================
vim.api.nvim_command('augroup RustLSP')
vim.api.nvim_command[[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }]]
vim.api.nvim_command('augroup END')
