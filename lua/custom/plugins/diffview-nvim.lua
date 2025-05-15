-- Better diff (compare) UI/UX in a single new tab
-- docs at https://github.com/sindrets/diffview.nvim/blob/main/doc/diffview.txt
-- :DiffviewOpen [git rev] [options] [ -- {paths...}]
-- ex diff a file with the secondlast commit
-- :DiffviewOpen HEAD
-- ex diff a file with an specific commit
-- :[range]DiffviewFileHistory [paths] [options]
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>oda', '<CMD>DiffviewOpen<CR>', desc = '[a]LL files git [d]iffview w/HEAD' },
    { '<leader>odd', '<CMD>DiffviewOpen HEAD -- %<CR>', desc = 'CURRENT file git [d]iffview w/HEAD' },
    { '<leader>odh', '<CMD>DiffviewFileHistory %<CR>', desc = 'CURRENT file [h]istory view' },
    { '<leader>odH', '<CMD>DiffviewFileHistory<CR>', desc = 'ALL files [H]istory view / git log' },
  },
}
