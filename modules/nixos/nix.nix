{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  system.activationScripts."upgrade-diff" = {
    supportsDryActivation = true;
    text = ''
      ${lib.getExe pkgs.nvd} \
        --nix-bin-dir=${config.nix.package}/bin \
        diff /run/current-system "$systemConfig"
    '';
  };

  nix = {
    package = pkgs.lix;

    settings = {
      auto-optimise-store = pkgs.stdenv.isLinux;
      experimental-features =
        [
          "nix-command"
          "flakes"
          "auto-allocate-uids"
        ]
        # TODO: remove this nonsense when all implementations remove repl-flake
        ++ lib.optional (
          lib.versionOlder config.nix.package.version "2.22.0" # repl-flake was removed in nix 2.22.0
          || lib.versionAtLeast config.nix.package.version "2.90.0" # but not in lix yet
        ) "repl-flake";

      nix-path = config.nix.nixPath;
    };

    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 5d";
    };
  };

  nixpkgs = {
    config.allowUnfree = lib.mkDefault true;
    overlays = with inputs.self.overlays; [
      additions
      unstable-packages
    ];
  };

  home-manager.backupFileExtension = "backup";
}
