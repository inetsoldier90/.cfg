return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 15,
            direction = "horizontal",
            close_on_exit = true,
            dir = "git_dir",
        })

        vim.keymap.set({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<CR>")
    end
}
