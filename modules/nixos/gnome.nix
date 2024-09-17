{pkgs, ...}: {
  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour
      # totem # video player
      epiphany # web browser
      simple-scan
      yelp
      # gnome-terminal
      # gnome-system-monitor
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = with pkgs; [
      adw-gtk3
      blackbox-terminal
      celluloid
    ];
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [pkgs.xterm];
  };
}
