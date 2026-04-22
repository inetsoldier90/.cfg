return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("todo-comments").setup({
			signs = true,
		})

		vim.keymap.set("n", "]T", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[T", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })

		vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "List todo comments" })
	end,
}
