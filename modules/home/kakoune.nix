{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.software.editor.kakoune;
in {
  options.software.editor.kakoune = {
    enable = lib.mkEnableOption "Kakoune Editor";
  };

  config = lib.mkIf cfg.enable {
    programs.kakoune = {
      enable = true;

      plugins = with pkgs.kakounePlugins; [
        kakoune-lsp
      ];

      config = {
        autoReload = "yes";
        numberLines = {
          enable = true;
          highlightCursor = true;
          relative = true;
        };
        indentWidth = 4;
        scrollOff = {
          lines = 3;
        };
        hooks = [
          {
            group = "global";
            name = "InsertCompletionShow";
            option = ".*";
            commands = "map window insert <tab> <c-n>";
          }
          {
            group = "global";
            name = "InsertCompletionShow";
            option = ".*";
            commands = "map window insert <s-tab> <c-p>";
          }
          {
            group = "global";
            name = "InsertCompletionHide";
            option = ".*";
            commands = "map window insert <tab> <c-n>";
          }
          {
            group = "global";
            name = "InsertCompletionHide";
            option = ".*";
            commands = "map window insert <s-tab> <c-p>";
          }
        ];
      };
      extraConfig = builtins.concatStringsSep "\n" [
        "add-highlighter global/ regex \\h+$ 0:Error" # Highlight trailing whitspaces
      ];
    };

    home.packages = with pkgs; [
      nil
    ];

    xdg.configFile."kak-lsp/kak-lsp.toml".text = ''
      snippet_support = false
      verbosity = 2
      [server]
      timeout = 1800 # seconds = 30 minutes

      [language.nix]
      filetypes = ["nix"]
      roots = ["flake.nix", "shell.nix", ".git"]
      command = "nil"
    '';
  };
}
