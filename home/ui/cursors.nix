{ config, pkgs, ... }:

let
  cursorSize = 14;
in {
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Lavender-Cursors";
    package = pkgs.catppuccin-cursors.mochaLavender;
    gtk.enable = true;
    size = cursorSize;
  };
}