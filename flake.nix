{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.ozpv = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ 
          ./configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      devShells.x86_64-linux = {
        default = (import ./shells/all.nix {inherit pkgs;});
        haemolacriaa = (import ./shells/haemolacriaa.nix {inherit pkgs;});
      };
    };
}
