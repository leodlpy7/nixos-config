{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    sl
    jetbrains.idea-ultimate
    noto-fonts
    noto-fonts-emoji
    (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    xournalpp
    android-studio
    android-tools
    libreoffice-still
    arkpandora_ttf
    playerctl
    grim
    rofi-bluetooth
    wlinhibit
    tmux
    vscodium
  ];
}
