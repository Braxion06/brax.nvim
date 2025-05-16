return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()
    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- Plugin mnemonic
    vim.keymap.set('n', '<leader>jj', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[j]ump w/Telescope' })

    -- Search mnemonic
    vim.keymap.set('n', '<leader>sj', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[S]earch [j]ump w/Telescope' })
  end,
  keys = {
    {
      mode = 'n',
      '<leader>ja',
      function()
        require('harpoon'):list():add()
      end,
      desc = '[a]dd file',
    },
    {
      mode = 'n',
      '<leader>jl',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = '[j]ump [l]ist',
    },
    {
      mode = 'n',
      '<leader>jn',
      function()
        require('harpoon'):list():next()
      end,
      desc = '[j]ump [n]ext',
    },
    {
      mode = 'n',
      '<leader>jp',
      function()
        require('harpoon'):list():prev()
      end,
      desc = '[j]ump [p]revious',
    },
    {
      mode = 'n',
      '<leader>j1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = '[j]ump to [1]',
    },
    {
      mode = 'n',
      '<leader>j2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = '[j]ump to [2]',
    },
    {
      mode = 'n',
      '<leader>j3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[j]ump to [3]',
    },
    {
      mode = 'n',
      '<leader>j4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = '[j]ump to [4]',
    },
    {
      mode = 'n',
      '<leader>j5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = '[j]ump to [5]',
    },
    {
      mode = 'n',
      '<leader>j6',
      function()
        require('harpoon'):list():select(6)
      end,
      desc = '[j]ump to [6]',
    },
    {
      mode = 'n',
      '<leader>j7',
      function()
        require('harpoon'):list():select(7)
      end,
      desc = '[j]ump to [7]',
    },
    {
      mode = 'n',
      '<leader>j8',
      function()
        require('harpoon'):list():select(8)
      end,
      desc = '[j]ump to [8]',
    },
    {
      mode = 'n',
      '<leader>j9',
      function()
        require('harpoon'):list():select(9)
      end,
      desc = '[j]ump to [9]',
    },
  },
  opts = {
    menu = {
      width = 120,
    },
  },
}
