-- Mason tools to install manually via :Mason
-- Formatters: stylua, prettier, isort, black, csharpier
-- Built into language toolchain (no Mason needed): rustfmt (Rust)

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua                = { "stylua" },
        python             = { "isort", "black" },
        javascript         = { "prettier" },
        javascriptreact    = { "prettier" },
        typescript         = { "prettier" },
        typescriptreact    = { "prettier" },
        html               = { "prettier" },
        css                = { "prettier" },
        json               = { "prettier" },
        yaml               = { "prettier" },
        markdown           = { "prettier" },
        rust               = { "rustfmt" },
        cs                 = { "csharpier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>gf", function()
      require("conform").format({ async = true })
    end, { desc = "Format buffer" })
  end,
}
