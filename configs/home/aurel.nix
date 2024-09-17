{
  ezModules,
  osConfig,
  pkgs,
  ...
}: {
  imports = with ezModules; [
    gamedev
    gtk
    kakoune
    kitty
    spotify
    vscode

    (let
      hostname = osConfig.networking.hostName;
    in
      if (builtins.hasAttr hostname ezModules)
      then (import (builtins.getAttr hostname ezModules))
      else {})
  ];

  home = rec {
    username = "aurel";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
    packages = with pkgs; [
      unstable.keepassxc
      gitkraken
    ];
  };

  programs.chromium.enable = true;
}
