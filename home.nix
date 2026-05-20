{ config, pkgs, libs, inputs, ... }:

{
  imports = [ ./apps/firefox.nix ./apps/nixvim.nix ];

  home.username = "ozpv";
  home.homeDirectory = "/home/ozpv";
  home.stateVersion = "25.05";

  gtk.enable = true;

  gtk.theme.package = pkgs.gruvbox-gtk-theme;
  gtk.theme.name = "Gruvbox-Green";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [ veracrypt keepassxc neofetch ];

  home.sessionVariables = { EDITOR = "nvim"; };

  programs.home-manager.enable = true;

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./etc/nixos/nvim/init.lua;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cp = "cp -v";
      mv = "mv -v";
      rm = "rm -v";
      mkdir = "mkdir -v -p";
      rmdir = "rmdir -v";
      ls = "ls -hla --color=auto";
      l = "ls -hla --color=auto";
      ll = "ls -hla --color=auto";
      grep = "grep --color=auto";
      bvim = "vim";
      vim = "nvim";
    };

    history.size = 10000;
  };
}
