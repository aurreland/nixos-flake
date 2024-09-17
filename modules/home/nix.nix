{inputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = with inputs.self.overlays; [
      additions
      unstable-packages
    ];
  };
}
