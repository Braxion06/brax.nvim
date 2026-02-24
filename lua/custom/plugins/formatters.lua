-- Formatters
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = 'n',
      desc = '[f]ormat buffer',
    },
    {
      '<leader>of',
      function()
        if not vim.g.disable_autoformat then
          vim.g.disable_autoformat = true
        else
          vim.g.disable_autoformat = false
        end
        vim.notify('Toggled Conform format on save status: ' .. vim.inspect(not vim.g.disable_autoformat), vim.log.levels.INFO)
      end,
      mode = 'n',
      desc = 'Toggle auto[f]ormat',
    },
  },
  opts = {
    notify_on_error = true,
    -- Autoformat
    format_on_save = function(bufnr)
      -- Disable format_on_save if vim.g.disable_autoformat is true
      if vim.g.disable_autoformat then
        vim.notify('Saved without formatting', vim.log.levels.INFO)
        return nil
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 2000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      -- Conform can also run multiple formatters sequentially
      lua = { 'stylua' },
      -- python = { 'isort', 'black' },
      python = {
        -- To fix auto-fixable lint errors.
        'ruff_fix',
        -- To run the Ruff formatter.
        'ruff_format',
        -- To organize the imports.
        'ruff_organize_imports',
      },
      -- Turned off yamlfmt because i dont want to use it on my ansible lab
      -- yaml = { 'yamlfmt' },
      --
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'markdownlint', 'prettierd', 'prettier', stop_after_first = true },
      -- sqlfluff will call the .sqlfluff file and as a fallback the postgres dialect
      sql = { 'sqlfluff', 'sqlfluff_default_dialect', stop_after_first = true },
      html = { 'prettierd' },
      json = { 'prettierd' },
      css = { 'prettierd' },
      go = { 'goimports' },
    },
    formatters = {
      sqlfluff_default_dialect = {
        command = 'sqlfluff',
        -- NOTE:
        -- Fix is for soft formatting, errors out if  a rule cannot be applied like Aliases
        -- Format is for force formatting never errors out
        -- Postgres is my default dialect
        -- The args goes like this sqlfluff format --dialect postgres -
        -- The `-` makes sqlfluff accept the standard input(the current buffer) instead of a file
        -- This is a unix convention, noevim is executing:
        -- echo "<buffer contents>" | sqlfluff format --dialect postgres -
        -- in the background
        args = { 'format', '--dialect', 'postgres', '-' },
        stdin = true,
      },
    },
  },
}
