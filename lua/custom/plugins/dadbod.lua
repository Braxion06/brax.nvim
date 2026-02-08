return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'pgsql' }, lazy = true },
      { 'tpope/vim-dotenv' },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    lazy = true,
    keys = {
      -- Toggle on/off DBUI
      {
        '<leader>os',
        '<CMD>DBUIToggle<CR>',
        mode = 'n',
        desc = 'Toggle DBUI [s]QL',
      },
      {
        '<leader>oS',
        '<CMD>tabnew<CR><BAR><BAR><CMD>DBUI<CR>',
        mode = 'n',
        desc = 'Toggle DBUI [S]QL in a NewTab',
      },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_show_help = 1
      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_disable_mappings_sql = 0
      -- default false, opening any table helper will also automatically run its query
      vim.g.db_ui_auto_execute_table_helpers = 0
      -- Default query save directory: ~/.local/share/db_ui
      -- vim.g.db_ui_save_location =
      -- Execute query on save
      vim.g.db_ui_execute_on_save = 0
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
    config = function()
      vim.keymap.set('v', '<C-e>', '<Plug>(DBUI_ExecuteQuery)', { desc = '[E]xecute query' })
      vim.keymap.set('n', '<C-e>', 'vap<Plug>(DBUI_ExecuteQuery)', { desc = '[E]xecute query around paragraph' })
    end,
  },
}
