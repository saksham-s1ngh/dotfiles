return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()

		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				-- "rust_analyzer",  -- requires rustup: brew install rustup && rustup-init
				"html",
				"cssls",
				"jsonls",
				"yamlls",
			},
			automatic_enable = {
				exclude = { "roslyn_ls" },
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP hover" })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
				vim.keymap.set({ "n", "v" }, "<leader>ca", function() require("actions-preview").code_actions() end, { buffer = bufnr, desc = "Code action preview" })
				vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, { buffer = bufnr, desc = "Go to references" })
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostic" })
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Prev diagnostic" })
			end,
		})
	end,
}
