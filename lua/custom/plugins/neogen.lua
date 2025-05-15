-- Neogen Documentation Generator
-- which will generate a proper documentation skeleton
-- based on certain expressions (mainly functions)
-- Generate docstrings
return {
  'danymat/neogen',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'L3MON4D3/LuaSnip',
  },
  lazy = true,
  cmd = 'Neogen',
  keys = {
    { '<leader>Gd', ':Neogen<CR>', desc = 'Generate Doc with Neogen' },
  },
  config = function()
    require('neogen').setup {
      silent = true,
      snippet_engine = 'luasnip',
      -- Change default conventaion
      -- languages = {
      --  -- python's default is google_docstring, others: ('numpydoc', 'reST')
      --   python = {
      --     template = { annotation_convention = 'google_docstring' },
      --   },
      -- },
    }
  end,
}
