require("config.lazy")
require("config.set")
require("config.map")


if vim.g.neovide then
    require("config.neovide")
end

-- Auto-save on buffer leave
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    callback = function()
        local success, err = pcall(function()
            vim.cmd("silent! wall")
        end)
        if not success then
            vim.notify("Auto-save failed: " .. err, vim.log.levels.WARN)
        end
    end,
})

vim.diagnostic.config({
    virtual_text=true,
})