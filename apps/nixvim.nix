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

      treesitter = {
        enable = true;
        folding = false;
        settings.indent.enable = true;
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

      lspkind.enable = true;

      luasnip.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
  
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
  
          mapping = {
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
  
          sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "crates";}
            {name = "buffer";}
          ];
        };
      };
  
      rustaceanvim = {
        enable = false;
  
        settings = {
          tools.enable_clippy = true;
        };
      };

      lualine.enable = true;
    };

    colorschemes.gruvbox.enable = true;

    extraPlugins = with pkgs.vimPlugins; [ vim-toml ];
  };
}
