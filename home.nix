{ config, pkgs, libs, inputs, ... }:

{
  imports = [ 
    ./apps/firefox.nix 
    ./apps/nixvim.nix
    ./apps/spicetify.nix
  ];

  home.username = "ozpv";
  home.homeDirectory = "/home/ozpv";
  home.stateVersion = "24.11";

  gtk.enable = true;

  gtk.cursorTheme.package = pkgs.catppuccin-cursors.mochaDark;
  gtk.cursorTheme.name = "catppuccin-mocha-dark-cursors";
  gtk.theme.package = pkgs.catppuccin-gtk;
  gtk.theme.name = "catppuccin-gtk-theme-mocha";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    veracrypt
    keepassxc
    neofetch
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./etc/nixos/nvim/init.lua;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cp = "cp -v";
      mv = "mv -v";
      rm = "rm -v";
      mkdir = "mkdir -v -p";
      rmdir = "rmdir -v";
      ls = "ls -hla --color=auto";
      grep = "grep --color=auto";
      vim-basic = "vim";
      vim = "nvim";
    };
    
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = fetchGit {
          url = "https://github.com/zsh-users/zsh-autosuggestions.git";
          rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchGit {
          url = "https://github.com/zsh-users/zsh-syntax-highlighting.git";
          rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
        };
      }
    ];
  };
}
