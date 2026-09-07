-- Mason tools to install manually via :Mason
-- Linters: eslint_d, ruff
-- C# linting is handled by Roslyn's built-in diagnostics (no separate linter needed)

return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost" },
  config = function()
    require("lint").linters_by_ft = {
      javascript      = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript      = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python          = { "ruff" },
    }

    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
