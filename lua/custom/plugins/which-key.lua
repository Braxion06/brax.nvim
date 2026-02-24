-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    win = {
      height = { min = 5, max = 15 },
    },
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font},

    -- Document existing key chains
    spec = {
      { 'gr', group = 'LSP [r]references', mode = { 'n' } },
      { '<leader>b', group = '[B]readcrumbs', mode = { 'n' } },
      { '<leader>d', group = '[d]ebug' },
      { '<leader>D', group = '[D]BUI - SQL' },
      { '<leader>e', group = '[e]rrors and diagnostics' },
      { '<leader>G', group = '[G]enerate' },
      { '<leader>j', group = '[J]ump w/Harpoon' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>i', group = '[i]nformation' },
      { '<leader>r', group = '[r]un REPL w/Iron.nvim' },
      { '<leader>s', group = '[s]earch', mode = { 'n' } },
      { '<leader>s', group = '[s]ort', mode = { 'v' } },
      { '<leader>S', group = '[S]plit' },
      { '<leader>t', group = '[t]est code' },
      { '<leader>o', group = 'Toggle [O]ptions' },
      { '<leader>od', group = 'Toggle [d]iffviews' },
      { '<leader>og', group = 'Toggle [g]itsigns' },
      { '<leader>oT', group = 'Toggle [T]odo' },
      { '<leader>ot', group = 'Toggle [t]est' },
      { '<leader>or', group = 'Toggle [r]un / REPL' },
    },
  },
}
