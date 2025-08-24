-- Set leader key to space
-- Now, "<leader>" in key mappings will be treated as " "
vim.g.mapleader = " "

------------------------------------------------------------------------------------------------------
-- HELPER FUNCTIONS TO CONCISELY DEFINE KEY MAPPINGS -------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Define normal mode mapping
local function n(keys, exec, options)
	return vim.keymap.set("n", keys, exec, options)
end
-- Define insert-mode mapping
local function i(keys, exec, options)
	return vim.keymap.set("i", keys, exec, options)
end
-- Define visual-mode mapping
local function v(keys, exec, options)
	return vim.keymap.set("v", keys, exec, options)
end
-- Define normal mode mapping that starts with leader key.
-- For example, `nlr("t", "...")` is equivalent to `n("<leader>t", "...")`
local function nlr(keys, exec, options)
	return n("<leader>" .. keys, exec, options)
end
-- Define visual mode mapping that starts with leader key.
-- For example, `vlr("t", "...")` is equivalent to `v("<leader>t", "...")`
local function vlr(keys, exec, options)
	return v("<leader>" .. keys, exec, options)
end

-- vim surround
-- n("ysw", "ysiw")
-- vim.api.nvim_set_keymap("n", "ysw", "ysiw", { noremap = false })

------------------------------------------------------------------------------------------------------
-- NORMAL LEADER -------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- Tab
nlr("t", ":tabnew<CR>")

-- LSP Restart
nlr('`', ':LspRestart<CR>')

-- Close buffers
nlr('.`', ':%bd|e#|bd#<CR>')

-- Save, quit, source
nlr("s", ":call TryWrite()<CR>", { silent = true })
nlr("q", ":call SmartQuit()<CR>", { silent = true })
nlr("Q", ":wqa")
nlr("2", ":w<bar> :source %<CR>")

-- Fold remove
-- nlr("fr", [[:%s/# }}}$\|# {{{$//g<CR>]])

-- Open terminal
nlr("//", ":terminal<CR>")

-- Yank paste system clipboard
nlr("y", '"+y')
nlr("p", '"+p')

-- Bring next element after comma down vertically
nlr("d", "f,lxi<CR><Esc>0")

-- Clear search highlighters
nlr("l", ":nohl<CR>")

-- Previous file
nlr("b", "<c-^>")

-- Window commands
nlr("w", "<c-w>")
nlr("we", "<c-w>=")

nlr("H", ":wincmd H<CR>", { silent = true })
nlr("J", ":wincmd J<CR>", { silent = true })
nlr("K", ":wincmd K<CR>", { silent = true })
nlr("L", ":wincmd L<CR>", { silent = true })

-- Change LOCAL working directory to current file
nlr(".cur", ":lcd %:p:h<CR>")
-- Change GLOBAL working directory to current file
nlr(".cg", ":cd %:p:h<CR>")

-- Markdown Table Mode (Kicamon/markdown-table-mode.nvim)
nlr("i", ":Mtm<CR>")

-- COLOR COLUMN ---------------------------------

local colorcolumn_width = 90
local colorcolumn_visible = false
local width_step = 10

-- Toggle
nlr('cc', function()
    if colorcolumn_visible then
        vim.opt.colorcolumn = ""
        colorcolumn_visible = false
    else
        vim.opt.colorcolumn = tostring(colorcolumn_width)
        colorcolumn_visible = true
        print("colorcolumn=" .. colorcolumn_width)
    end
end)
-- Decrement if visible
nlr('c<', function()
    if colorcolumn_visible then
        colorcolumn_width = colorcolumn_width - width_step
        vim.opt.colorcolumn = tostring(colorcolumn_width)
        print("colorcolumn=" .. colorcolumn_width)
    end
end)
-- Increment if visible
nlr('c>', function()
    if colorcolumn_visible then
        colorcolumn_width = colorcolumn_width + width_step
        vim.opt.colorcolumn = tostring(colorcolumn_width)
        print("colorcolumn=" .. colorcolumn_width)
    end
end)

------------------------------------------------------------------------------------------------------
-- NORMAL --------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- Use q macro
-- n("<C-M>", "@q")
n("<CR>", "@q")

-- Easier fold toggle
n("zm", "za")

-- Keep cursor inplace when appending row beneath to current
n("J", "mzJ`z")

-- Keep search terms in middle
n("n", "nzzzv")
n("N", "Nzzzv")

-- Move tabs
n(">", ":tabn<CR>")
n("<", ":tabp<CR>")

------------------------------------------------------------------------------------------------------
-- VISUAL --------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- Yank/paste with system clipboard
v("y", '"+y')

-- Stay in visual line after indenting selection
v("<", "<gv")
v(">", ">gv")

-- Shift visual lines up and down
v("J", ":m '>+1<CR>gv=gv")
v("K", ":m '<-2<CR>gv=gv")

-- Adjust window width
-- v("[", ':<C-U>vertical resize -5<CR>gv', { noremap = true, silent = true, nowait = true})
-- v("]", ':<C-U>vertical resize +5<CR>gv', { noremap = true, silent = true, nowait = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':vertical resize -6<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-]>', ':vertical resize +6<CR>', { noremap = true, silent = true})
-- n('[', ':vertical resize -5<CR>', { noremap = true, silent = true})
-- n(']', ':vertical resize +5<CR>', { noremap = true, silent = true})


------------------------------------------------------------------------------------------------------
-- TERMINAL ------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- Escape terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})


------------------------------------------------------------------------------------------------------
-- PLUGIN --------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- Markdown Preview
nlr("4", ":MarkdownPreview<CR>")

-- COPILOT
-- nlr('ch', ":Copilot help<CR>")
-- nlr('cp', ":Copilot panel<CR>")
-- nlr('cs', ":Copilot status<CR>")
-- nlr('cd', ":Copilot disable<CR>")
-- nlr('ce', ":Copilot enable<CR>")
--
-- vim.api.nvim_set_keymap('i', '<C-Space><Space>', '<Plug>(copilot-next)', {noremap = false, silent = true})
-- vim.api.nvim_set_keymap('i', '<C-Space>s', '<Plug>(copilot-suggest)', {noremap = false, silent = true})

-- VIM-RUN-PYTHON
nlr("r", ":call ExecutePythonNewBuffer()<CR>")
nlr("R", "5<C-w>j:q<CR><C-w><C-p>", { silent = true })

-- VIM-MAXIMIZER
nlr("m", ":MaximizerToggle<CR>")

-- COMMENTER (we need recursive version of mapping)
vim.api.nvim_set_keymap("n", "T", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "T", "gcgv", { noremap = false })

-- FILE EXPLORER
nlr("e", ":NvimTreeToggle<CR>", { silent = true })

-- -- TELESCOPE
-- local blt = require("telescope.builtin")
-- nlr("fr", blt.resume, {})
-- nlr("fn", blt.find_files, {}) -- Lists files in your current working directory, respects .gitignore
-- nlr("fo", blt.oldfiles, {}) -- Lists previously open files
-- nlr("fs", blt.live_grep, {}) -- Search for a string in your current working directory and get results live as you type, respects .gitignore
-- nlr("fc", blt.grep_string, {}) -- Searches for the string under your cursor in your current working directory
-- nlr("fb", blt.buffers, {}) -- Lists open buffers in current neovim instance
-- nlr("fk", blt.keymaps, {}) -- Lists normal mode keymappings
-- nlr("/", blt.current_buffer_fuzzy_find, {}) -- Live fuzzy search inside of the currently open buffer

-- nlr("gc", blt.git_commits) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
-- nlr("gfc", blt.git_bcommits) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- nlr("gb", blt.git_branches) -- list git branches (use <cr> to checkout) ["gb" for git branch]
-- nlr("gs", blt.git_status) -- list current changes per file with diff preview ["gs" for git status]

-- To toggle showing LSP diagnostics means to toggle showing the virtual text
-- that's overlayed over your code with the error/warning messages.
nlr("gh", ":lua ToggleShowDiag()<CR>")
ShowDiagnostics = true
function ToggleShowDiag()
	if ShowDiagnostics then
		ShowDiagnostics = false
		vim.diagnostic.enable(false)
	else
		ShowDiagnostics = true
		vim.diagnostic.enable(true)
	end
	-- vim.diagnostic.config({ virtual_text = ShowDiagnostics })
end

-- Run autoformatter for the current buffer, if a language-specific formatter exists.
nlr("z", ":lua FormatWithNullLS()<CR>")
function FormatWithNullLS()
    local current_filetype = vim.bo.filetype
    local name_to_look_for = "null-ls"

    if current_filetype == "python" then
        name_to_look_for = "ruff"
    end

    vim.lsp.buf.format({
        filter = function(client)
            return client.name == name_to_look_for
        end,
    })
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- code leader key
local function ncode(keys, exec, options)
	return n("<CR>" .. keys, exec, options)
end
local function icode(keys, exec, options)
	return i("<C-m>" .. keys, exec, options)
end