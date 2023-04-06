local options = {
  ensure_installed = {
        "lua",
        "cpp",
        "c",
        "javascript",
        "java",
        "vim"
    },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require 'nvim-treesitter.install'.compilers = { "clang" }
return options
