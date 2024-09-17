{pkgs, lib, osConfig, ...}: {
  programs.gpg.enable = true;

    services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      pinentryPackage = osConfig.programs.gnupg.agent.pinentryPackage or pkgs.pinentry-curses;
    };
}
