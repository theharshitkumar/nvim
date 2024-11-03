return {
    "mbbill/undotree",
    lazy = false,
    config = function()
        local utils = require('./utils')
       
        if vim.fn.has("win32") == 1 then
            vim.g.undotree_DiffCommand = utils.get_nvim_path('/bin/diff.exe')
        end
    end,
    keys = {{
        "<leader>u",
        function() vim.cmd.UndotreeToggle() end,
        desc = "Toggle undotree"
    }}
}
