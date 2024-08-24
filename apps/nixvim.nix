{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;

    keymaps = [
      # Equivalent to nnoremap ; :
      {
        key = ";";
        action = ":";
      }

      # Equivalent to nmap <silent> <buffer> <leader>gg <cmd>Man<CR>
      {
        key = "<leader>gg";
        action = "<cmd>Man<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      # Etc...
    ];

    # We can set the leader key:
    globals.mapleader = " ";

    # We can also set options:
    opts = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = false;

      mouse = "a";

      # etc...
    };

    plugins = {
      lazy.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>lg" = "live_grep";
        };
      };

      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua-ls.enable = true;
          bashls.enable = true;
          html.enable = true;
          pyright.enable = true;
          jsonls.enable = true;
          java-language-server.enable = true;
          cmake.enable = true;
          sqls.enable = true;
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };
    };

    colorschemes.gruvbox.enable = true;

    extraPlugins = with pkgs.vimPlugins; [ vim-toml ];
  };
}
