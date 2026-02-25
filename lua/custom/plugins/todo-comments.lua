-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  config = function()
    require('todo-comments').setup {
      signs = true,
    }
    vim.keymap.set('n', '<leader>oT', '<CMD>TodoQuickFix<CR>', { desc = 'Toggle [T]odo quickfix' })
    vim.keymap.set('n', '<leader>st', '<CMD>TodoTelescope<CR>', { desc = '[s]earch [t]odo Comments' })
  end,
}
