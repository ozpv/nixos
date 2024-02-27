{ config, pkgs, libs, ... }:

{
  imports = [ ./firefox.nix ];

  gtk.enable = true;

  gtk.cursorTheme.package = pkgs.simp1e-cursors;
  gtk.cursorTheme.name = "Simp1e-Gruvbox-Dark";
  gtk.theme.package = pkgs.gruvbox-dark-gtk;
  gtk.theme.name = "gruvbox-dark";

  home.username = "ozpv";
  home.homeDirectory = "/home/ozpv";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    keepassxc
    neofetch
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

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