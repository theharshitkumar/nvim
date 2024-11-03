return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {"python", "angular", "css", "lua", "vim", "vimdoc", "query", "elixir", "heex",
                                "javascript", "html"},
            sync_install = false,
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            }
        })
    end
}

-- local M = {
--     "nvim-treesitter/nvim-treesitter",
--     build = function()
--         require("nvim-treesitter.install").update({ with_sync = true })()
--     end,
-- }

-- return { M }
