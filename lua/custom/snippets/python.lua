-- Clear snippets for this language
-- require('luasnip.session.snippet_collection').clear_snippets 'python'

local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node

local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('python', {
  s(
    'ax',
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
