{ config, pkgs, ... }:

{
  environment.variables = {
    EDITOR = "vi";
    GTK_THEME = "Dracula";
    FLAKE = "/home/lucysue/.dotfiles";
  };
}
