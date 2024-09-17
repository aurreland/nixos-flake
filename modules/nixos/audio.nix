{lib, ...}: {
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services = {
    pipewire = lib.mkDefault {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
