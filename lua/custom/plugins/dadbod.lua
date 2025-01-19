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
        '<CMD>DBUIToggle<CR>',
        mode = 'n',
        desc = '[T]oggle DBUI [S]QL',
      },
      {
        '<leader>tS',
        '<CMD>tabnew<CR><BAR><BAR><CMD>DBUI<CR>',
        mode = 'n',
        desc = '[T]oggle DBUI [S]QL in a NewTab',
      },
      {
        '<C-e>',
        '<Plug>(DBUI_ExecuteQuery)',
        mode = { 'v' },
        desc = '[E]xecute query',
      },
      {
        '<C-e>',
        'vap<Plug>(DBUI_ExecuteQuery)',
        mode = { 'n' },
        desc = '[E]xecute query around paragraph',
      },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_show_help = 1
      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_disable_mappings_sql = 0
      vim.g.dbs = {
        -- dev =  "postgresql://postgres:postgres@localhost:5432/postgres"
      }

      -- If $DBUI_URL env variable exists, it will be added as a connection.
      -- Name for the connection will be parsed from the url.
      -- If you want to use a custom name, pass $DBUI_NAME alongside the url.
      -- Env variables that will be read can be customized like this:

      -- vim.g.db_ui_env_variable_url = 'DATABASE_URL'
      -- vim.g.db_ui_env_variable_name = 'DATABASE_NAME'

      -- Optionally you can leverage dotenv.vim to specific any number of connections
      -- in an .env file by using a specific prefix (defaults to DB_UI_).
      -- The latter part of the env variable becomes the name of the connection (lowercased)
      -- # .env
      -- DB_UI_DEV=...          # becomes the `dev` connection
      -- DB_UI_PRODUCTION=...   # becomes the `production` connection
    end,
  },
}
