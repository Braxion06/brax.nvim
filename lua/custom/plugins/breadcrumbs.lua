-- Breadcrumbs at the top of neovim
-- nvim-navic is a common dependency, Lazy shoul dedup the install/configuration
return {
  {
    'LunarVim/breadcrumbs.nvim',
    event = 'LspAttach',
    cond = function()
      -- Don't load in terminal buffer
      return vim.bo.buftype ~= 'terminal'
    end,
    dependencies = {
      { 'SmiteshP/nvim-navic' },
    },
    config = function()
      require('breadcrumbs').setup()
    end,
  },

  -- Breadcrumbs navigation
  {
    'hasansujon786/nvim-navbuddy',
    keys = { { '<leader>bn', '<CMD>Navbuddy<CR>', desc = '[n]avbuddy breadcrumbs' } },
    dependencies = {
      { 'SmiteshP/nvim-navic', opts = {
        lsp = {
          auto_attach = true,
        },
      } },
      'MunifTanjim/nui.nvim',
    },
    opts = { lsp = { auto_attach = true } },
  },
}
