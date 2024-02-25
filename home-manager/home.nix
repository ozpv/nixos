{ config, pkgs, ... }:

{
  home.username = "ozpv";
  home.homeDirectory = "/home/ozpv";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
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
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.8.0";
          sha256 = lib.fakeSha256;
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "v0.7.0";
          sha256 = lib.fakeSha256;
        };
      }
    ];
  }
}
