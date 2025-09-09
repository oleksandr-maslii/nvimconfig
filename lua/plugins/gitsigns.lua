return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 300,
            },
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '-' },
            }
        })
    end
}
