{
  ezModules,
  pkgs,
  ...
}: {
  imports = with ezModules; [
    ./hardware-configuration.nix

    audio
    fonts
    gnome
    lanzaboote
    steam
    zram-optimization
  ];

  networking.hostName = "demeter";

  users.users.aurel = {
    isNormalUser = true;
    initialPassword = "aurel";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  system.stateVersion = "24.05";
}
