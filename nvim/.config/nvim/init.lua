-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before lazy
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Load plugins
require("lazy").setup("plugins")

-- General Configuration
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.textwidth = 80
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.backupcopy = "yes"
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Enable syntax and filetype
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- Enable treesitter highlighting for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua", "vim", "help", "javascript", "typescript", "typescriptreact",
    "html", "css", "json", "yaml", "markdown", "go", "ruby", "python", "c", "cpp",
  },
  callback = function()
    vim.treesitter.start()
  end,
})

-- Theme
vim.cmd("colorscheme OceanicNext")

-- Custom Key Bindings

-- Insert blank line below with 'n' (mapped from :put_)
vim.keymap.set("n", "n", ":put_<CR>", { silent = true })

-- '\y' Copy to system clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- '\x' Cut to system clipboard
vim.keymap.set("v", "<leader>x", '"+x')
vim.keymap.set("n", "<leader>x", '"+x')

-- '\d' Deleting without yanking
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>dd", '"_dd')
vim.keymap.set("v", "<leader>dd", '"_dd')

-- Spell checking for markdown files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_ca"
  end,
})
