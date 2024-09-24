return {
  'christoomey/vim-tmux-navigator',
  keys = {
    { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<CR>' },
    { '<C-j>', '<cmd><C-U>TmuxNavigateDown<CR>' },
    { '<C-K>', '<cmd><C-U>TmuxNavigateUp<CR>' },
    { '<C-l>', '<cmd><C-U>TmuxNavigateRight<CR>' },
    -- { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
