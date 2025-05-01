-- Highlight, edit, and navigate code
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'c_sharp',
        'diff',
        'dockerfile',
        'gitignore',
        'go',
        'html',
        'javascript',
        'jinja',
        'jinja_inline',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'sql',
        'toml',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    -- Treesitter context show the context at the top of the editor based on your cursor
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    -- NOTE: Stopped loading the plugin with keys, this are defined below
    -- keys = {
    --   { '<leader>tt', '<CMD>TSContextToggle<CR>', mode = 'n', desc = 'Toggle [t]reesitter context window' },
    -- },
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false, -- Enable multiwindow support.
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true, -- Show line numbers in the context's window
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
    },
    vim.keymap.set('n', '<leader>tt', '<CMD>TSContextToggle<CR>', { desc = 'Toggle [t]reesitter context window' }),
  },
}
