{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        actionlint.enable = true;
        deadnix.enable = true;
        just.enable = true;
        alejandra.enable = true;
        statix.enable = true;
      };
    };
  };
}
