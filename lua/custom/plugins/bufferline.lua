return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'TabNew',
  opts = {
    options = {
      mode = 'tabs',
      indicator = {
        icon = '',
        style = 'icon',
      },
      separator_style = 'thick',
      always_show_bufferline = false,
      auto_toggle_bufferline = false,
      diagnostics = 'nvim_lsp',
      show_buffer_close_icons = false,
      show_close_icons = false,
    },
  },
}
