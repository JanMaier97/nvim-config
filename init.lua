-- bootstrap lazy.vim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

require("lazy").setup({
    "navarasu/onedark.nvim",
    "tpope/vim-fugitive", 
    "tpope/vim-surround", 
    "tpope/vim-commentary",
    "tpope/vim-vinegar",
    "neovim/nvim-lspconfig",
    "junegunn/goyo.vim",
    "preservim/vim-pencil",
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    },
    "nvim-telescope/telescope-fzy-native.nvim",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" }
    }
})

-- Set tab behaviour to 4 spaces
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- enable relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.cmd.colorscheme('onedark')

-- ensure plugin indent is enabled for tpope/commentary plugin
vim.cmd("filetype plugin indent on")

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('keymappings');
require('plugins');

