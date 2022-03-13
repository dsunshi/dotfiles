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
