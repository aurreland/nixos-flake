{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      popupLyrics
      shuffle
      powerBar
      fullAlbumDate
      writeify
      autoVolume
      copyToClipboard
      adblock
      beautifulLyrics
    ];
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      ncsVisualizer
    ];
    spotifyPackage = pkgs.spotify;
  };
}
