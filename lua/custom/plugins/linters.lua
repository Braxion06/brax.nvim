return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- NOTE: Not needed for now
      -- lint.linters.sqlfluff = {
      --   cmd = 'sqlfluff',
      --   name = 'sqlfluff',
      --   args = { 'lint', '--dialect', 'postgres', '-', '-v' },
      --   stdin = false,
      --   stream = 'stderr',
      -- }

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
        yaml = { 'yamllint' },
        -- NOTE: This is not required, LSP(ansiblels) is calling ansible-lint
        -- ansible = { 'ansible_lint' },
        --
        -- python = { 'pylint' },
        -- NOTE: This is not required, LSP(ruff) is calling ansible-lint
        -- python = { 'ruff' },
        dockerfile = { 'hadolint' },
        sql = { 'sqlfluff' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        dotenv = { 'dotenv_linter' },
      }
      --NOTE: Pylint configuration, json output and disable a subset of rules
      lint.linters.pylint.cmd = 'pylint'
      lint.linters.pylint.args = {
        '-f',
        'json',
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
        '--disable',
        'import-error, trailing-newlines, missing-function-docstring, missing-module-docstring',
      }
      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then lint.try_lint() end
        end,
      })
    end,
  },
}
