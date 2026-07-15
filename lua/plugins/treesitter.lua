return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        init = function()
            local ensureInstalled = {
                "sql",
                "css",
                "scss",
                "go",
                "c_sharp",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "typescript",
                "dockerfile",
                "rust"
            }
            local alreadyInstalled = require("nvim-treesitter.config").get_installed()

            local toInstall = vim.iter(ensureInstalled)
                :filter(function (parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
                :totable()

            require("nvim-treesitter").install(toInstall)
        end,
    },
}
