{ pkgs, ... }:

{
  extensions = with pkgs.vscode-extensions; [ jnoortheen.nix-ide ];

  userSettings = {
    "nix.formatterPath" = "nixfmt";
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";

    "nix.serverSettings" = {
      "nixd" = { "formatting" = { "command" = [ "nixfmt" ]; }; };
    };
  };
}
