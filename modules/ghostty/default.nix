{ ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";

      font-family = "Hack Nerd Font";
      font-size = 18;

      # background-opacity = 0.95

      cursor-style = "bar";

      window-padding-x = 4;
      window-padding-y = 4;

      window-height = 30;
      window-width = 102;
    };
  };
}
