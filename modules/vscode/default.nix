{ pkgs, ... }:
let
  makeProfile = { userSettings ? { }, extensions ? [ ] }: {
    userSettings = userSettings // {
      "editor.fontFamily" =
        "'CaskaydiaCove Nerd Font', 'JetBrains Mono', 'monospace', monospac";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;

      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "git.autofetch" = true;

      "workbench.iconTheme" = "icons";
    };

    extensions = with pkgs.vscode-extensions;
      [ file-icons.file-icons github.copilot github.copilot-chat ]
      ++ extensions;
  };
in {
  programs.vscode = {
    enable = true;
    profiles = {
      "DevOps" = makeProfile (import ./profiles/devops.nix { inherit pkgs; });
      "Go" = makeProfile (import ./profiles/go.nix { inherit pkgs; });
      "NodeJS" = makeProfile (import ./profiles/node.nix { inherit pkgs; });
    };
  };
}
