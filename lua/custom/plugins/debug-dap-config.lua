-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      {
        'rcarriga/nvim-dap-ui',
        keys = {

          {
            '<leader>od',
            function()
              require('dapui').toggle {}
            end,
            desc = 'Toggle [d]ap/Debugging UI',
          },
          {
            '<leader>de',
            function()
              require('dapui').eval()
            end,
            desc = '[e]val',
            mode = { 'n', 'v' },
          },
        },
      },

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Virtual text for nvim-dap
      'theHamsta/nvim-dap-virtual-text',

      -- Add your own debuggers here
      -- 'leoluz/nvim-dap-go', -- Go
    },
    keys = {
      -- Basic debugging keymaps, feel free to change to your liking!
      {
        '<leader>ds',
        function()
          require('dap').continue()
        end,
        desc = '[d]ebug: ▶ [s]tart/Continue',
      },
      {
        '<leader>d<F5>',
        function()
          require('dap').continue()
        end,
        desc = '[d]ebug: ▶ [s]tart/Continue',
      },
      {
        '<leader>dc',
        function()
          require('dap').run_to_cursor()
        end,
        desc = '[d]ebug: 󰒭 to [c]ursor',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = '[d]ebug: Step [i]nto',
      },
      {
        '<leader>d<F1>',
        function()
          require('dap').step_into()
        end,
        desc = '[d]ebug: Step [i]nto',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = '[d]ebug: Step [o]ver',
      },
      {
        '<leader>d<F2>',
        function()
          require('dap').step_over()
        end,
        desc = '[d]ebug: Step [o]ver',
      },
      {
        '<leader>dr',
        function()
          require('dap').step_out()
        end,
        desc = 'Debug: Step [r]eturn/Out',
      },
      {
        '<leader>d<F3>',
        function()
          require('dap').step_out()
        end,
        desc = 'Debug: Step [r]eturn/Out',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = '[d]ebug: Toggle [b]reakpoint',
      },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[d]ebug: Set [B]reakpoint w/condition',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {
        '<leader>dR',
        function()
          require('dapui').toggle()
        end,
        desc = '[d]ebug session [R]esult',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = '[d]ebug:  down[j]',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = '[d]ebug:  up[k]',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = '[d]ebug:  [l]ast',
      },
      {
        '<leader>dL',
        function()
          require('dap').repl.toggle()
        end,
        desc = '[d]ebug:  Toggle REPL [l]oop',
      },
      {
        '<leader>dq',
        function()
          require('dap').terminate()
        end,
        desc = '[d]ebug: ⏹ [q]uit/Terminate',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = '[d]ebug: ⏸ [p]ause',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = '[d]ebug: 󰜬 [w]idgets',
      },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'python',
          -- 'delve',
        },
      }

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- NOTE: Yanked this from @tjdevries, it's a secret masker
      require('nvim-dap-virtual-text').setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
            return '*****'
          end

          if #variable.value > 15 then
            return ' ' .. string.sub(variable.value, 1, 15) .. '... '
          end

          return ' ' .. variable.value
        end,
      }

      -- Change breakpoint icons
      vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
      vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
      local breakpoint_icons = vim.g.have_nerd_font
          and { Breakpoint = '●', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
      for type, icon in pairs(breakpoint_icons) do
        local tp = 'Dap' .. type
        local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end

      -- Auto open DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open

      -- Auto close DAP UI after events
      -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      -- require('dap-go').setup {
      --   delve = {
      --     -- On Windows delve must be run attached or it crashes.
      --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      --     detached = vim.fn.has 'win32' == 0,
      --   },
      -- }
    end,
  },

  {
    'mfussenegger/nvim-dap-python', -- Python
    dependencies = {

      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    lazy = true,
    ft = 'python',
    keys = {
      {
        '<leader>dt',
        function()
          require('dap-python').test_method()
        end,
        desc = '[d]ebug/[t]est closest method above',
        mode = 'n',
      },
    },
    config = function(_, opts)
      -- Install python config
      -- It needs Debugpy and nvim-dap, uv should install it on the venv
      -- Or just Install it on venv and remove it from the project in the output file
      require('dap-python').setup 'uv'
      -- Remember to install pytest on venv
      require('dap-python').test_runner = 'pytest'
    end,
  },
}
-- dap-python.debug_selection
