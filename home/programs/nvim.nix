{ config, pkgs, ... }:

{
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withPython3 = true;
  programs.neovim.viAlias = true;
}