-- Thanks to https://github.com/adibhanna/nvim
-- NVIM homescreen
return {
  'goolord/alpha-nvim',
  enabled = true,
  event = 'VimEnter',
  lazy = true,
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'
    local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
__________________________________________________
    ]]

    dashboard.section.header.val = vim.split(logo, '\n')
    dashboard.section.buttons.val = {
      dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
      dashboard.button('g', '󰑑' .. ' Find with RegEx(grep)', ':Telescope live_grep <CR>'),
      dashboard.button('s', ' ' .. 'Restore Session', '<CMD>lua require("persistence").load()<cr>'),
      dashboard.button('c', ' ' .. ' Config', ':e ~/.config/nvim/ <CR>'),
      dashboard.button('l', '󰒲 ' .. ' Lazy', '<CMD>Lazy<CR>'),
      dashboard.button('m', ' ' .. ' Mason', '<CMD>Mason<CR>'),
      dashboard.button('q', ' ' .. ' Quit', '<CMD>qa<CR>'),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'
    dashboard.opts.layout[1].val = 10
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AlphaReady',
        callback = function()
          require('lazy').show()
        end,
      })
    end
    require('alpha').setup(dashboard.opts)

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local v = vim.version()
        local nvim_version = string.format('%d.%d.%d', v.major, v.minor, v.patch)
        dashboard.section.footer.val = '⚡ Neovim ' .. nvim_version .. ' loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
