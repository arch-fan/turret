{ ... }: {
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [┌─>](bold green) [at](bold blue) $directory$all\\
        [└>](bold green) $username $battery$character'';

      character = {
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
      };
    };
  };
}
