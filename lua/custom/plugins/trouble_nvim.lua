-- Better diagnostics handling and navigation
return {
  'folke/trouble.nvim',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = 'Trouble',
  keys = {
    {
      '<leader>ew',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = '[w]orkspace Errors and Diagnostics(Trouble)',
    },
    {
      '<leader>ee',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Current Buffer [e]rrors and Diagnostics(Trouble)',
    },
    {
      '<leader>es',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = '[s]ymbols (Trouble)',
    },
    {
      '<leader>el',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = '[l]SP Definitions / references / ... (Trouble)',
    },
  },
}
