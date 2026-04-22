return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
				["q"] = { "actions.close", mode = "n" },
			},
		})

		vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Oil: open parent directory" })
		vim.keymap.set("n", "<leader>o", "<cmd>Oil --float<CR>", { desc = "Oil: floating window" })
	end,
}
