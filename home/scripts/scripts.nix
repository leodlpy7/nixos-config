{ config, pkgs, ... }:

{
  home.packages = [
    (import ./waybar-wlinhibit.nix { inherit pkgs; })
  ];
}