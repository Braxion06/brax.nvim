-- Formatting
return {
  -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 2000,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      -- Conform can also run multiple formatters sequentially
      lua = { 'stylua' }, -- Lua
      python = { 'isort', 'black' }, -- Python
      -- Turned off yamlfmt because i dont want to use it on my ansible lab
      -- yaml = { 'yamlfmt' }, -- YAML
      --
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      -- sqlfluff will call the .sqlfluff file and as a fallback the postgres dialect
      sql = { 'sqlfluff', 'sqlfluff_default_dialect', stop_after_first = true },
      html = { 'prettierd' },
      json = { 'prettierd' },
    },
    formatters = {
      sqlfluff_default_dialect = {
        command = 'sqlfluff',
        -- Fix is for soft formatting, errors out if  a rule cannot be applied like Aliases
        -- Format is for force formatting never errors out
        -- Postgres is my default dialect
        args = { 'format', '--dialect', 'postgres', '-' },
        stdin = true,
      },
    },
  },
}
