-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[q]uickfix list' })

-- Delete with `x` without affecting the default registers.
vim.keymap.set('n', 'x', '"_x')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- Easily hit escape in terminal mode.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Split keybinds
vim.keymap.set('n', '<leader>SH', '<C-w>s', { desc = '[H]orizontal split ' })
vim.keymap.set('n', '<leader>SV', '<C-w>v', { desc = '[V]ertical split ' })
vim.keymap.set('n', '<leader>SQ', '<C-w>c', { desc = '[Q]uit (close) split' })

-- Sort lines
vim.api.nvim_set_keymap('v', '<leader>ss', ':sort i<CR>', { desc = '[s]ort', noremap = true })
vim.api.nvim_set_keymap('v', '<leader>sr', ':sort! i<CR>', { desc = '[r]everse sort', noremap = true })

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set('n', '<leader>-', function()
  vim.cmd.new()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
  vim.wo.winfixheight = true
  vim.cmd.term()
  vim.cmd 'startinsert'
end, { desc = 'Terminal' })

-- Write changes, use :w, its faster or the same as <leader>W
-- vim.keymap.set('n', '<leader>W', ':w', { desc = '[W]rite changes' })

-- Cycle between buffers
vim.keymap.set('n', 'gb', '<CMD>bnext<CR>', { desc = '[G]o to next [b]uffer' })
vim.keymap.set('n', 'gB', '<CMD>bnext<CR>', { desc = '[G]o to previous [b]uffer' })

-- Open a tab
vim.keymap.set('n', '<leader><Tab>', '<CMD>tabnew<CR>', { desc = 'Create [Tab]' })

-- Close tab
vim.keymap.set('n', '<leader><S-Tab>', '<CMD>tabclose<CR>', { desc = 'Close [Tab]' })

-- Cycle tabs with `gt` and 'gT' instead
-- vim.keymap.set('n', '<leader><Tab>', '<CMD>tabnext<CR>', { desc = 'Next [Tab]' })

-- Quit all buffers without saving
vim.keymap.set('n', '<leader>Q', '<CMD>qa!<CR>', { desc = '[Q]uit all without saving' })

-- Diff keymaps
vim.keymap.set('n', '<leader>ods', '<CMD>windo diffthis<CR>', { desc = '[d]iff [s]plits' })
vim.keymap.set('n', '<leader>odt', '<CMD>diffthis<CR>', { desc = '[d]iff [t]his file' })

-- vim.keymap.set('n', '<leader>ibn', "<CMD>echo expand('%')<CR>", { desc = '[b]uffer [n]ame' })
--
-- vim.keymap.set('n', '<leader>ibp', function()
--   print(vim.api.nvim_buf_get_name(0))
-- end, { desc = '[b]uffer [p]ath' })

-- Informational keymaps
vim.keymap.set('n', '<leader>in', "i<C-R>=expand('%')<CR><Esc>", { desc = ' Paste Buffer [n]ame' })
