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
-- FIX: Remove
-- build = ':TSUpdate',
-- main = 'nvim-treesitter.config', -- Sets main module to use for opts
-- -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
-- opts = {
--   ensure_installed = {
--     'bash',
--     'c',
--     'c_sharp',
--     'cpp',
--     'diff',
--     'dockerfile',
--     'git_rebase',
--     'gitcommit',
--     'gitignore',
--     'go',
--     'gomod',
--     'html',
--     'helm',
--     'java',
--     'javascript',
--     'jinja',
--     'jinja_inline',
--     'json',
--     'just',
--     'lua',
--     'luadoc',
--     'make',
--     'markdown',
--     'markdown_inline',
--     'python',
--     'query',
--     'regex',
--     'scala',
--     'sql',
--     'toml',
--     'typescript',
--     'vim',
--     'vimdoc',
--     'xml',
--     'yaml',
--   },
--   -- Autoinstall languages that are not installed
--   auto_install = true,
--   highlight = {
--     enable = true,
--     -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--     --  If you are experiencing weird indenting issues, add the language to
--     --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--     additional_vim_regex_highlighting = { 'ruby' },
--   },
--   indent = { enable = true, disable = { 'ruby' } },
-- },
-- -- There are additional nvim-treesitter modules that you can use to interact
-- -- with nvim-treesitter. You should go explore a few and see what interests you:
-- --
-- --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
-- --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
-- --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
