return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "javascript", "typescript", "tsx",
        "python", "rust", "go",
        "html", "css", "json", "yaml", "markdown",
      },
      auto_install = true,
    })

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldlevel = 99
  end,
}
