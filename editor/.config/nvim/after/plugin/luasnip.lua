local ls = require "luasnip"

ls.snippets = {
    all = {
        -- Available for all filetypes
        ls.parser.parse_snippet("expand", "-- hello world"),
    },
    rust = {
        -- rust snippets
        ls.parser.parse_snippet("fn", "fn ${1:name}(${2:arg}: ${3:type}) -> ${4:ret} {\n    ${5:todo!();}\n}"),
    },
}
