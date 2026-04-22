return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { { "goimports", "gofmt" } },
                json = { "prettier" },
                jsonc = { "prettier" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
			},
		})
	end,
}
