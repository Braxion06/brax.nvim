return {
  {
    'folke/noice.nvim',
    opts = function(_, opts)
      -- Initialize opts.routes if it is nil
      opts.routes = opts.routes or {}
      table.insert(opts.routes, {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd('FocusGained', {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd('FocusLost', {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = 'notify_send',
        opts = { stop = false },
      })

      -- Setup commands
      opts.commands = opts.commands or {}
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = 'split',
          opts = { enter = true, format = 'details' },
          filter = {},
        },
      }

      -- Initialize presets if it is nil
      opts.presets = opts.presets or {}
      opts.presets.lsp_doc_border = true

      -- Markdown with notifications
      -- vim.lsp.util.convert_input_to_markdown_lines = true
      -- vim.lsp.util.stylize_markdown = true
    end,
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      timeout = 5000,
      background_colour = '#000000',
      render = 'wrapped-compact',
      stages = 'slide',
      top_down = true,
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
    },
    keys = {
      {
        '<leader>sN',
        '<CMD>Telescope notify<CR>',
        mode = 'n',
        desc = '[S]earch [N]otifications',
      },
    },
  },
}
