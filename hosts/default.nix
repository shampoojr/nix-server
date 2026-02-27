{inputs, ...}: {
  server = {
    system = "x86_64-linux";
    modules = [
      ./clients/server/configuration.nix
    ];
  };
}