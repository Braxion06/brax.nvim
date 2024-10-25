return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
      { 'tpope/vim-dotenv', lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    keys = {
      -- Toggle on/off DBUI
      {
        '<leader>ts',
        '<cmd>DBUIToggle<CR>',
        mode = 'n',
        desc = '[T]oggle DBUI [S]QL',
      },
      {
        '<leader>tS',
        '<CMD>tabnew<CR><BAR><Bar><CMD>DBUI<CR>',
        mode = 'n',
        desc = '[T]oggle DBUI [S]QL in a NewTab',
      },
      {
        '<C-e>',
        '<Plug>(DBUI_ExecuteQuery)',
        mode = { 'n', 'v' },
        desc = '[E]xecute query',
      },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_show_help = 1
      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_disable_mappings_sql = 0
    end,
  },
}
