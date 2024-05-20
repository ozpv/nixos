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

require("lazy").setup({
  "nvim-telescope/telescope.nvim",
  "nvim-treesitter/treesitter.nvim",
  -- gruvbox colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      mason.setup()
      lspconfig.pyright.setup {}
      lspconfig.tsserver.setup {}
      lspconfig.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {},
        },
      }
    end,
  }
})
