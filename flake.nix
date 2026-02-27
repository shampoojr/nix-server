{
  description = "NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs = {
      url = "github:Nixos/nixpkgs/nixos-unstable";
    };

    # Hardware
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    specialArgs = {inherit inputs system;};
    hosts = import ./hosts/default.nix {inherit inputs;};
    user = import ./home/default.nix {inherit inputs;};
    mkHost = _: attrs:
      lib.nixosSystem {
        inherit (attrs) system;
        specialArgs = specialArgs;
        modules = attrs.modules or [];
      };
    mkHome = _: attrs:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit (attrs) system;
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = specialArgs;
        modules =
          attrs.modules or [];
      };
  in {
    nixosConfigurations = lib.mapAttrs mkHost hosts;
    homeConfigurations = lib.mapAttrs mkHome user;
  };
}