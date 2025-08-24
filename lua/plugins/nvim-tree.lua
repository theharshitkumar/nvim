return {
  "nvim-tree/nvim-tree.lua",
  version = "*", -- use latest stable version
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  config = function()
    -- Disable netrw (recommended by nvim-tree docs)
    vim.g.loaded = 1
    vim.g.loaded_netrwPlugin = 1

    -- Custom highlight for indent markers
    vim.cmd([[ highlight NvimTreeIndentMarker guifg=#CCCCCC ]])

    -- Attach function to override/extend default mappings
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- Load default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Your custom mapping
      vim.keymap.set("n", "i", api.tree.change_root_to_node, opts("CD As New Root"))
    end

    require("nvim-tree").setup({
      on_attach = on_attach,
      renderer = {
        highlight_opened_files = "all", -- Highlight opened files
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = true,
          },
        },
      },
      filters = {
        git_ignored = false,
        custom = {  "__pycache__", "node_modules", "*.git"},
      },
    })
  end,
}
