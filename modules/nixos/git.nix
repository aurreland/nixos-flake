{pkgs, ...}: {
  programs.git = {
    enable = true;
    config = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
  environment.systemPackages = with pkgs; [
    github-desktop
  ];
}
