-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
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

-- Create notification with vim.notify plugin while recording macros
vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
    desc = 'Notify when recording a macro',
    group = vim.api.nvim_create_augroup ('macro-notify', { clear = true}),
    callback = function(ev)
      local msg
      if ev.event == 'RecordingEnter' then
        msg = 'Recording to register @'
      else
        msg = 'Recorded to register @'
      end
      vim.notify(msg .. vim.fn.reg_recording(), vim.log.levels.INFO, { title = 'Macro', hide_from_history = false })
    end,
  })
