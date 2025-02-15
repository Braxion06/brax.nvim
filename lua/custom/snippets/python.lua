-- Python Snippets
-- Clear snippets for this language each time the config is loaded
require('luasnip.session.snippet_collection').clear_snippets 'python'

local ls = require 'luasnip'
-- local extras = require 'luasnip.extras'

-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node

local fmt = require('luasnip.extras.fmt').fmt
-- local rep = extras.rep

ls.add_snippets('python', {
  s(
    { trig = 'ax', name = 'Matplotlib simple plot', desc = 'Matplotlib simple plot snippet' },
    fmt(
      " \
	ax.set_xlabel('{}')\
	ax.set_ylabel('{}')\
	ax.legend(title='{}')\
	plt.show()",
      { i(1), i(2), i(0) }
    )
  ),
  s('pr', fmt("print('{}')", { i(1, 'Print description') })),
})
