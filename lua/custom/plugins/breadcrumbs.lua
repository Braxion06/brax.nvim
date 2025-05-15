-- Breadcrumbs at the top of neovim
-- nvim-navic is a common dependency, Lazy shoul dedup the install/configuration
return {
  {
    'LunarVim/breadcrumbs.nvim',
    event = 'LspAttach',
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
    keys = { { '<leader>bN', '<CMD>Navbuddy<CR>', desc = '[N]avbuddy breadcrumbs' } },
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
