
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

    -- Rust
    -- =========================================================================
    use 'rust-lang/rust.vim'

    -- Code Editing (IDE)
    -- =========================================================================
    use 'tomtom/tcomment_vim'                          -- Code commenting
    use 'tpope/vim-fugitive'                           -- Git integration
    use 'tommcdo/vim-lion'                             -- Text alignment
    use 'plasticboy/vim-markdown'                      -- Markdown support
    use 'kshenoy/vim-signature'                        -- Place, toggle, and display marks.
    use 'tpope/vim-surround'                           -- Change text surrounds
    use 'junegunn/fzf.vim'                             -- Fuzzy searching
    use 'justinmk/vim-sneak'                           -- Text search

    use 'nvim-treesitter/nvim-treesitter'              -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects'  -- Additional textobjects for treesitter

    -- LSP / Autocomplete
    -- =========================================================================
    use 'nvim-lua/lsp_extensions.nvim'  -- Extensions to built-in LSP, for example, providing type inlay hints
    use 'neovim/nvim-lspconfig'         -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp'              -- A completion engine
    use 'hrsh7th/cmp-nvim-lsp'          -- Completions based on the LSP client
    use 'hrsh7th/cmp-buffer'            -- Completions for buffer words
    use 'hrsh7th/cmp-path'              -- Completions for filesystem paths
    use 'hrsh7th/cmp-cmdline'           -- Completions for command mode

    -- Snippets
    -- =========================================================================
    use 'SirVer/ultisnips'            -- Snippets plugin

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
-- Editor {{{1
-- =============================================================================

local tabsize = 4

vim.opt.number         = true                          -- Show line numbers in gutter
vim.opt.relativenumber = true                          -- Show relative numbers in gutter
vim.opt.textwidth      = 80                            -- Automatically hard wrap at 80 columns
vim.opt.scrolloff      = 3                             -- Start scrolling 3 lines before edge of viewport
vim.opt.cursorline     = true                          -- Highlight current line
vim.opt.expandtab      = true                          -- Always use spaces instead of tabs
vim.opt.fillchars      = {
  diff                 = '∙',                          -- Bullet operator (U+2219, UTF-8: E2 88 99)
  eob                  = ' ',                          -- No-break space (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold                 = '·',                          -- Middle dot (U+00B7, UTF-8: C2 B7)
  vert                 = '┃',                          -- Box drawings heavy vertical (U+2503, UTF-8: E2 94 83)
}
vim.opt.formatoptions  = vim.opt.formatoptions + 'j'   -- Remove comment leader when joining comment lines
vim.opt.formatoptions  = vim.opt.formatoptions + 'n'   -- Smart auto-indenting inside numbered lists
vim.opt.laststatus     = 2                             -- Always show status line
vim.opt.lazyredraw     = true                          -- Don't bother updating screen during macro playback
vim.opt.linebreak      = true                          -- Wrap long lines at characters in 'breakat'
vim.opt.list           = true                          -- Show whitespace
vim.opt.listchars      = {
  nbsp                 = '⦸',                          -- Circled reverse solidus (U+29B8, UTF-8: E2 A6 B8)
  extends              = '»',                          -- Right-pointing double angle quotation mark (U+00BB, UTF-8: C2 BB)
  precedes             = '«',                          -- Left-pointing double angle quotation mark (U+00AB, UTF-8: C2 AB)
  tab                  = '▷⋯',                         -- White right-pointing triangle (U+25B7, UTF-8: E2 96 B7) + midline horizontal ellipsis (U+22EF, UTF-8: E2 8B AF)
  trail                = '•',                          -- Bullet (U+2022, UTF-8: E2 80 A2)
}
vim.opt.shiftwidth    = tabsize                        -- Spaces per tab (when shifting)
vim.opt.tabstop       = tabsize                        -- Spaces per tab
vim.opt.showbreak     = '↳ '                           -- Downwards arrow with tip rightwards (U+21B3, UTF-8: E2 86 B3)
vim.opt.smarttab      = true                           -- <tab>/<BS> indent/dedent in leading whitespace

vim.opt.completeopt    = 'menuone,noinsert,noselect'   -- Better auto completion settings
vim.opt.shortmess      = vim.opt.shortmess + 'c'       -- Do not give ins-completion-menu messages

vim.opt.showmatch   = true                             -- Show matching (), [], or {}
vim.opt.colorcolumn = '120'                            -- Show the color column
-- =============================================================================
-- GUI {{{1
-- =============================================================================

vim.opt.guifont       = 'JetBrainsMono NF:h16'    -- Patched version from https://www.nerdfonts.com/#home
vim.opt.belloff       = 'all'                     -- Never ring the bell for any reason
vim.opt.splitbelow    = true                      -- Open horizontal splits below current window
vim.opt.splitright    = true                      -- Open vertical splits to the right of the current window

-- =============================================================================
-- Options {{{1
-- =============================================================================

-- Make sure the updated leader mapping is the first thing done
vim.g.mapleader = ' '           -- Map leader to space

-- Function to map keys
local map = vim.api.nvim_set_keymap
-- noremap is definitly a safe bet here
local default_opts = {noremap = true}

-- telescope settings
-- ==================
--  > keybindings

-- Search hidden folders, but not .git
map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)

map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", default_opts)
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", default_opts)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", default_opts)

vim.g.rustfmt_autosave = true   -- Format rust code when the buffer is saved

-- Disable folding in markdown since it is more of a pain than anything
vim.g.vim_markdown_folding_disabled = 1

local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
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

-- Rust LSP configuration
local nvim_lsp = require'lspconfig'

-- This will let rust-analyzer search the local path structure and use
-- the Cargo.toml file to find crates that have been listed as dependencies,
-- i.e. this will allow rust-anaylzer to play nice with crates listed in
-- Cargo.toml
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

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


-- =============================================================================
-- Auto Commands {{{1
-- =============================================================================
vim.api.nvim_command('augroup RustLSP')
vim.api.nvim_command[[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }]]
vim.api.nvim_command('augroup END')
