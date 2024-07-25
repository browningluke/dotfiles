local hooks = require "ibl.hooks"
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

local options = {
  enabled = true,

  exclude = {
    filetypes = {
      "help",
      "terminal",
      "lazy",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
      "nvdash",
      "nvcheatsheet",
      "",
    },
    buftypes = { "terminal" }
  },

  scope = {
    enabled = true,
    show_start = true
  },
}

require("ibl").setup(options)
