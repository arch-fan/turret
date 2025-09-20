{ pkgs, ... }:

{
  extensions = with pkgs.vscode-extensions; [
    astro-build.astro-vscode
    bradlc.vscode-tailwindcss
  ];
}
