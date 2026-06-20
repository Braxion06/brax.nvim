-- LSP Plugins
return {
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      {
        'mason-org/mason.nvim',
        opts = {},
        dependencies = { 'mason-org/mason-lspconfig.nvim' },
      },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
      --
      -- Show current code context
      { 'SmiteshP/nvim-navic', opts = {
        lsp = {
          auto_attach = true,
        },
      } },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- NOTE: This is not necessary
          -- Neovim has a default keybind to show the documentation on hover
          -- Show Hover Documentation about the symbol selected
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          -- Show Signature(parameters) help
          map('S', vim.lsp.buf.signature_help, 'Show signature Help')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>oh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Turn off Dinamyc watching for files
      -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --  See `:help lsp-config` for information about keys and how to configure
      -- LSPs (Language Server Protocol servers)
      local servers = {
        clangd = {}, -- C, C++
        -- csharp_ls = {}, -- C#
        gopls = {}, -- Go
        pyright = {}, -- Python
        -- NOTE: Ruff works through the LSP protocol
        ruff = { -- Python
          settings = {},
        },
        ansiblels = { -- Ansible
          filetypes = { 'yaml.ansible', 'ansible' },
          root_markers = { 'ansible.cfg', '.ansible-lint' }, -- Default from nvim-lspconfig
        },
        dockerls = {}, -- Dockerfile
        docker_compose_language_service = {}, -- Docker Compose
        yamlls = { -- YAML
          settings = {
            yaml = {
              validate = true,
            },
          },
        },
        bashls = {}, -- Sh and Bash
        sqlls = { -- SQL
          settings = {
            sqlLanguageServer = {
              -- FIX: This does not work, still need to create
              -- a .sqllsrc.json in $PWD in the projects that use it
              -- connections = {
              --   {
              --     name = 'dev_postgres',
              --     adapter = 'postgres',
              --     host = 'localhost',
              --     port = 5432,
              --   },
              -- },
              -- NOTE: Turned off sqlls linting, sqlfluff is better at this
              lint = {
                rules = {
                  align_column_to_the_first = 'off',
                  column_new_line = 'off',
                  linebreak_after_clause_keyword = 'off',
                  reserved_word_case = 'off',
                  space_surrounding_operators = 'off',
                  where_clause_new_line = 'off',
                  align_where_clause_to_the_first = 'off',
                },
              },
            },
          },
        },
        ts_ls = {}, -- Javascript and Typescript
        marksman = {}, -- Markdown
        -- vale_ls = {}, -- Advanced Markdown and Text
        -- rust_analyzer = {}, -- Rust
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
      }
      -- NOTE: MASON CONFIG
      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run :Mason
      --  You can press `g?` for help in this menu.

      local ensure_installed = vim.tbl_keys(servers or {})
      -- Add Tools here that you want mason to install
      vim.list_extend(ensure_installed, {
        -- Formatters
        'markdownlint', -- Markdown. Markdownlint is a formatter too
        'stylua', -- Used to format Lua code
        'isort', -- Python formatter for import statements
        'black', -- Python. Black is the uncompromising Python code formatter(PEP8 compliant)
        'ruff', -- Python. Ruff is a formatter too
        'yamlfmt', -- YAML
        'prettier', -- Javascript, Typescript, css, html
        'prettierd', -- Javascript, Typescript, css, html
        'sqlfluff', -- SQL -- Sqlfluff is a formatter too
        'shfmt', -- Shell
        -- bashls, -- Shell/Bash -- Bashls is a formatter too
        'goimports', -- Go, Formats just like gofmt and manages imports

        -- Linters
        'markdownlint', -- Markdown
        -- 'vale', -- Advanced Markdown and Text
        'jsonlint', -- JSON
        'pylint', -- Python
        -- 'ruff', -- Python
        -- 'flake8', -- Python
        'hadolint', -- Dockerfile
        'yamllint', -- YAML
        'ansible-lint', -- YAML.Ansible
        -- 'sqlfluff', -- SQL dialetcs
        'eslint_d', -- Javascript and Typescript
        'shellcheck', -- Shell
        'dotenv-linter', -- Dotenv
        'golangci-lint', -- Go

        -- DAPs (Debug Adapter Protocol)
        'debugpy', -- Python
        'js-debug-adapter', -- Javascript and Typescript
        'go-debug-adapter', -- Go Adapter
        'delve', -- Go Debugger
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end

      -- Special Lua Config, as recommended by neovim help docs
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              -- See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })
      vim.lsp.enable 'lua_ls'
    end,
  },
}
