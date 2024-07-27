{ pkgs, lib, spicetify-nix, ... }: 

{
  imports = [ spicetify-nix.homeManagerModule ];
  programs.spicetify = let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.system}; 
  in {
    # configure spicetify :)
    enable = true; # this is the line that will cause spotify to get installed
    theme = spicePkgs.themes.catppuccin-mocha;
    colorScheme = "mauve";
  #    enabledExtensions = with spicePkgs.extensions; [
  #      # "playlistIcons.js" # only needed if not using dribbblish
  #      "fullAlbumDate.js"
  #      "showQueueDuration.js"
  #      "playNext.js"
  #      "shuffle+.js"
  #    ];
  }
}
