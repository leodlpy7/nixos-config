{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      clock = true;
      indicator = true;
      screenshots = true;
      effect-scale = "0.8";
      effect-vignette = "0.2:0.5";
      effect-blur = "4x2";
      datestr = "%a %e.%m.%Y";
      timestr = "%k:%M";
      daemonize = true;
      show-failed-attempts = true;
      color = "1f1d2e80";
      font = "Inter";
      indicator-radius = 100;
      indicator-thickness = 10;
      line-color = "11111b";
      ring-color = "181825";
      inside-color = "1e1e1e";
      key-hl-color = "cba6f7";
      separator-color = "00000000";
      text-color = "cdd6f4";
      text-caps-lock-color = "";
      line-ver-color = "11111b";
      ring-ver-color = "cba6f7";
      inside-ver-color = "1e1e2e";
      text-ver-color = "cdd6f4";
      ring-wrong-color = "f38ba8";
      text-wrong-color = "f38ba8";
      inside-wrong-color = "1e1e2e";
      inside-clear-color = "1e1e2e";
      text-clear-color = "cdd6f4";
      ring-clear-color = "cba6f7";
      line-clear-color = "11111b";
      line-wrong-color = "11111b";
      bs-hl-color = "f38ba8";
      grace = 0;
      grace-no-touch = true;
      ignore-empty-password = true;
    };
  };
}
