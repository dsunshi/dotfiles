-- =============================================================================
-- Editor
--
-- This file configures the way vim feels when editing
-- =============================================================================

-- A tab is four spaces
local tabsize = 4

local opt = vim.opt

opt.number         = true                          -- Show line numbers in gutter
opt.relativenumber = true                          -- Show relative numbers in gutter
opt.textwidth      = 80                            -- Automatically hard wrap at 80 columns
opt.scrolloff      = 3                             -- Start scrolling 3 lines before edge of viewport
opt.cursorline     = true                          -- Highlight current line
opt.expandtab      = true                          -- Always use spaces instead of tabs
opt.fillchars      = {
  diff                 = '∙',                          -- Bullet operator (U+2219, UTF-8: E2 88 99)
  eob                  = ' ',                          -- No-break space (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold                 = '·',                          -- Middle dot (U+00B7, UTF-8: C2 B7)
  vert                 = '┃',                          -- Box drawings heavy vertical (U+2503, UTF-8: E2 94 83)
}
opt.formatoptions  = opt.formatoptions + 'j'   -- Remove comment leader when joining comment lines
opt.formatoptions  = opt.formatoptions + 'n'   -- Smart auto-indenting inside numbered lists
opt.laststatus     = 2                             -- Always show status line
opt.lazyredraw     = true                          -- Don't bother updating screen during macro playback
opt.linebreak      = true                          -- Wrap long lines at characters in 'breakat'
opt.list           = true                          -- Show whitespace
opt.listchars      = {
  nbsp                 = '⦸',                          -- Circled reverse solidus (U+29B8, UTF-8: E2 A6 B8)
  extends              = '»',                          -- Right-pointing double angle quotation mark (U+00BB, UTF-8: C2 BB)
  precedes             = '«',                          -- Left-pointing double angle quotation mark (U+00AB, UTF-8: C2 AB)
  tab                  = '▷⋯',                         -- White right-pointing triangle (U+25B7, UTF-8: E2 96 B7) + midline horizontal ellipsis (U+22EF, UTF-8: E2 8B AF)
  trail                = '•',                          -- Bullet (U+2022, UTF-8: E2 80 A2)
}
opt.shiftwidth    = tabsize                        -- Spaces per tab (when shifting)
opt.tabstop       = tabsize                        -- Spaces per tab
opt.showbreak     = '↳ '                           -- Downwards arrow with tip rightwards (U+21B3, UTF-8: E2 86 B3)
opt.smarttab      = true                           -- <tab>/<BS> indent/dedent in leading whitespace

opt.completeopt    = 'menuone,noinsert,noselect'   -- Better auto completion settings
opt.shortmess      = opt.shortmess + 'c'       -- Do not give ins-completion-menu messages

opt.showmatch   = true                             -- Show matching (), [], or {}
opt.colorcolumn = '120'                            -- Show the color column
