return {
  -- Catppuccin colorscheme
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  -- opts = {
  --   flavour = 'mocha',
  --   color_overrides = {
  --     -- Changed the mocha palette
  --     -- base (for background) changed to my terminal color
  --     -- mantle is now the original base color
  --     mocha = {
  --       base = '#1D1E1F',
  --       mantle = '#1e1e2e',
  --     },
  --   },
  -- },
  config = function()
    require('catppuccin').setup {
      term_colors = true,
      flavour = 'mocha',
      -- color_overrides = {
      --   -- Fixed Neovim color setting
      --   -- Changed the mocha palette
      --   -- base (for background) changed to my terminal color
      --   -- mantle is now the original base color
      --   mocha = {
      --     base = '#1D1E1F',
      --     mantle = '#1E1E2E',
      --   },
      -- },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
