return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
			python = { "ruff" },
			go = { "golangcilint" },
		}

		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = group,
			callback = function()
				require("lint").try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			require("lint").try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
