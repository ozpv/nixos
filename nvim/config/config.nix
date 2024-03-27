{
  colorschemes.gruvbox.enable = true;

  plugins = {
    lsp = {
      enable = true;
      servers = {
         tsserver.enable = true;
         lua-ls.enable = true;
         rust-analyzer.enable = true;
      };
    };
    lualine.enable = true;
    treesitter.enable = true;
    telescope.enable = true;
    rust-tools.enable = true;
  };
}
