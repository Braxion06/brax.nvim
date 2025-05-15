-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  cmd = 'Neotree',
  keys = {
    { '\\', '<CMD>Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>o\\', '<CMD>Neotree toggle left<CR>', desc = 'Toggle Neotree left', silent = true },
  },
  opts = {
    source_selector = {
      winbar = true,
      sources = {
        { source = 'filesystem', display_name = '   Files ' },
        -- { source = 'buffers', display_name = '   Buffers ' },
        { source = 'git_status', display_name = '   Git ' },
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = false, -- Only for Windows
        hide_by_pattern = {},
      },
    },
    window = {
      position = 'float', --default is left
    },
  },
}
