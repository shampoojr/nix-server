{inputs, ...}: {
  imports = [./imports];
  home = {
    username = "shampoojr";
    homeDirectory = "/home/shampoojr";
    file = {};
    sessionVariables = {
    };
  };
  programs.home-manager.enable = true;
}