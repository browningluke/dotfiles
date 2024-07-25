local options = {
  ensure_installed = { "vim", "lua", "rust", "toml" },
  auto_install = true,

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = false },
}

require("nvim-treesitter.configs").setup(options)
