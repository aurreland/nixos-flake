{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  programs.fish = {
    enable =
      if osConfig.programs.fish.enable
      then true
      else false;

    interactiveShellInit = ''
      ${lib.getExe pkgs.nix-your-shell} fish | source
      set fish_greeting
    '';

    shellAbbrs = {
      nixgc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };

    plugins = let
      mkFishPlugins = map (plugin: {
        name = plugin;
        inherit (pkgs.fishPlugins.${plugin}) src;
      });
    in
      mkFishPlugins ["autopair"];
  };
}
