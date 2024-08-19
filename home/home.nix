{ config, pkgs, ... }:

{
  # import other config files
  imports = [
    ./programs/sway/swayidle.nix
    ./programs/sway/swaylock.nix

    ./programs/term/fastfetch.nix
    ./programs/term/fish.nix
    ./programs/term/kitty.nix
    ./programs/term/starship.nix

    ./programs/wm/hyprland.nix
    ./programs/wm/hyprpaper.nix
    ./programs/wm/waybar.nix

    ./programs/git.nix
    ./programs/nvim.nix
    ./programs/rofi.nix

    ./scripts/scripts.nix

    ./ui/cursors.nix
    ./ui/gtk.nix
    ./ui/qt.nix

    ./pkgs.nix
  ];

  home.stateVersion = "18.09";
  home.username = "lucysue";
  home.homeDirectory = "/home/lucysue";

  # home manager
  programs.home-manager.enable = true;
}
