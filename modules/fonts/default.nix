{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ nerd-fonts.hack nerd-fonts.caskaydia-cove ];
}
