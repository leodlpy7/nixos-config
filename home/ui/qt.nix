{ config, pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };
}