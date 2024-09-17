{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  environment.systemPackages = [pkgs.sbctl];

  boot = {
    initrd.systemd.enable = true;

    kernelPackages = pkgs.linuxPackages_latest;

    loader.systemd-boot.enable = lib.mkForce false;

    loader.efi.canTouchEfiVariables = true;

    lanzaboote = {
      enable = true;

      pkiBundle = "/etc/secureboot";

      settings = {
        console-mode = "auto";
        editor = false;
        timeout = 60;
      };
    };

    supportedFilesystems = ["ntfs"];
  };
}
