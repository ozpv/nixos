{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;

    # fix rust_analyzer error
    extraConfigLua = "for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end";

    keymaps = [
      {
        key = ";";
        action = ":";
      }

      {
        key = "<leader>gg";
        action = "<cmd>Man<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
    ];

    globals.mapleader = " ";

    clipboard.register = "unnamedplus";

    opts = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = false;

      mouse = "a";
    };

    plugins = {
      lazy.enable = true;

      todo-comments.enable = true;

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
          ts_ls.enable = true;
          lua_ls.enable = true;
          bashls.enable = true;
          html.enable = true;
          pyright.enable = true;
          jsonls.enable = true;
          # java_language_server.enable = true;
          cmake.enable = true;
          sqls.enable = true;
          nixd.enable = true;
          tailwindcss.enable = true;
          # svelte.enable = true;
          rust_analyzer = {
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

      web-devicons.enable = true;

      lualine.enable = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "mocha";
        integrations = {
          cmp = true;
          treesitter = true;
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [ vim-toml ];
  };
}
