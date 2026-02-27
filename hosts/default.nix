{inputs, ...}: {
  Server = {
    system = "x86_64-linux";
    modules = [
      ./client/server/configuration.nix
      inputs.stylix.nixosModules.stylix
    ];
  };
}