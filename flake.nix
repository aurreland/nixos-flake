{
  description = "NixOs Configuration Flake";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        inputs.ez-configs.flakeModule

        ./dev
        ./overlays
      ];

      perSystem = {system, ...}: {packages = import ./pkgs inputs.nixpkgs.legacyPackages.${system};};

      ezConfigs = rec {
        globalArgs = {inherit inputs;};
        root = ./.;

        home = {
          modulesDirectory = "${root}/modules/home";
          configurationsDirectory = "${root}/configs/home";
        };

        nixos = {
          hosts.demeter = {
            importDefault = true;
            userHomeModules = ["aurel"];
          };
          modulesDirectory = "${root}/modules/nixos";
          configurationsDirectory = "${root}/configs/nixos";
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    ez-configs.url = "github:ehllie/ez-configs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        pre-commit-hooks-nix.follows = "";
      };
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
