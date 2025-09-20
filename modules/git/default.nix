{ ... }: 

{
  programs.git = {
    enable = true;
    userName = "arch-fan";
    userEmail = "juanserracines@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };
}
