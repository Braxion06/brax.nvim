-- Show on screen the last 5 keys pressed
return {
  'nvzone/showkeys',
  cmd = 'ShowkeysToggle',
  opts = {
    position = 'bottom-right',
    timeout = 1, -- seconds
    maxkeys = 4,
    -- Don't show keys during insert mode
    excluded_modes = { 'i' },
    -- Highlights
  },
  keys = { { '<leader>ok', '<CMD>ShowkeysToggle<CR>', desc = 'Toggle show [k]eys' } },
}
