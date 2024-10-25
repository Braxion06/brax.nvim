-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Not necessary, ftplugin handles it
-- -- Set up an autocmd group for filetype-specific indentation
-- vim.api.nvim_create_augroup('FileTypeIndent', { clear = true })
-- -- Set up an autocmd to change indentation on filetype
-- -- This autocmd group was defined in the autocmd file
-- vim.api.nvim_create_autocmd('FileType', {
--   group = 'FileTypeIndent',
--   pattern = 'sql',
--   callback = function()
--     vim.bo.shiftwidth = 4
--     vim.bo.tabstop = 4
--     vim.opt.softtabstop = 4
--     vim.bo.expandtab = true
--   end,
-- })
