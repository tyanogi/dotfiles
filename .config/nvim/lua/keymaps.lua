local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Keymap for Normal Mode

-- Keymap for Insert Mode
map('i', '<C-j>', '<Esc>', opts)

-- Keymap for Visual Mode
map('v', '<C-j>', '<Esc>', opts)
