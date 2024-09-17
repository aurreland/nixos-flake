{config, ...}: let
  xdgDirs = config.xdg.userDirs;
  homeDir = config.home.homeDirectory;
in {
  gtk.gtk3.bookmarks = [
    "file://${xdgDirs.documents} Documents"
    "file://${xdgDirs.download} Downloads"
    "file://${xdgDirs.pictures} Pictures"
    "file://${xdgDirs.music} Music"
    "file://${homeDir}/Media Media"
    "file://${homeDir}/.config Config"
    "file://${homeDir}/.local/share Local"
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${homeDir}/Media/Music";
      videos = "${homeDir}/Media/Videos";
      pictures = "${homeDir}/Media/Pictures";
      templates = null;
      download = "${homeDir}/Media/Downloads";
      documents = "${homeDir}/Media/Documents";
      desktop = "Desktop";
      publicShare = null;
    };
  };
}
