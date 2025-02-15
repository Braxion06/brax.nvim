-- Kubernetes snippets
-- Clear snippets for this language each time the config is loaded
require('luasnip.session.snippet_collection').clear_snippets 'yaml'

local ls = require 'luasnip'
local extras = require 'luasnip.extras'

-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = extras.rep

ls.add_snippets('yaml', {
  s(
    { trig = 'manifest', name = 'Kubernetes manifest', desc = 'Generate a kubernetes manifest file' },
    fmt(
      "---\
apiVersion: {}\
kind: {}\
metadata:\
  name: {}\
  labels:\
    app.kubernetes.io/name: {}\
    app.kubernetes.io/instance: {}\
    app.kubernetes.io/version: '{}'\
    app.kubernetes.io/component: {}\
    app.kubernetes.io/part-of: {}\
    app.kubernetes.io/managed-by: {}\
spec:\
  {}",
      {
        i(1, 'API'),
        i(2, 'Resource type'),
        i(3, 'Application name'),
        rep(3),
        i(4, 'Unique instance name'),
        i(5, 'Application version'),
        i(6, 'Component within the architecture'),
        i(7, 'Higher level application'),
        i(8, 'Management tool'),
        i(9, 'Spec keys'),
      }
    )
  ),
})
