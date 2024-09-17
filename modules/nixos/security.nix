{lib, ...}: {
  security = {
    polkit.enable = true;
    audit.enable = true;
    auditd.enable = true;
    apparmor.enable = true;

    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["aurel"]; # TODO: Make this automated
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  services.dbus.apparmor = lib.mkDefault "enabled";
}
