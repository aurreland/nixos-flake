{
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        packages = with pkgs;
          [
            # format + lint
            actionlint
            self'.formatter
            deadnix
            nil
            statix
            home-manager
            git
            vim
          ]
          ++ lib.optionals pkgs.stdenv.isLinux [
            (pkgs.nixos-rebuild.override {nix = pkgs.lix;}) # ditto
            # inputs'.agenix.packages.agenix
          ];
      };
    };
  };
}
