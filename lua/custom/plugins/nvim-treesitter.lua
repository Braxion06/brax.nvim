-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local filetypes = {
      'bash',
      'c',
      'c_sharp',
      'cpp',
      'diff',
      'dockerfile',
      'git_rebase',
      'gitcommit',
      'gitignore',
      'go',
      'gomod',
      'html',
      'helm',
      'java',
      'javascript',
      'jinja',
      'jinja_inline',
      'json',
      'just',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'scala',
      'sql',
      'toml',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    }
    require('nvim-treesitter').install(filetypes)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function() vim.treesitter.start() end,
    })
  end,
}
