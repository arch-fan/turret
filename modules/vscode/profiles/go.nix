{ pkgs, ... }:

{
  extensions = with pkgs.vscode-extensions; [ golang.go ];
}
