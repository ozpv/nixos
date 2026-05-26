{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.ozpv = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs = { inherit inputs; }; }
        ];
      };

      devShells.x86_64-linux = {
        default = (import ./shells/all.nix { inherit pkgs; });
        haemolacriaa = (import ./shells/haemolacriaa.nix { inherit pkgs; });
      };
    };
}
