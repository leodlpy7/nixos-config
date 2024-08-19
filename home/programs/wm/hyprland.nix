{ config, pkgs, ... }:

let
  opacity = "dd";
  active_color = "b117c3";
  inactive_color = "595959";

  wallpaper_path = "~/.dotfiles/resources/wallpapers/anime-night-sky.png"; # set wallpaper image
in {
  home.packages = [
    pkgs.hyprpaper
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      # monitor config
      monitor = [
        "eDP-1, preferred, auto, 1"
        "HDMI-A-1, preferred, auto, auto"
      ];

      exec-once = [
        "waybar & hyprpaper & hypridle"
        "swayidle -w"
      ];

      # input
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        touchpad.natural_scroll = "yes";
        sensitivity = 0;
      };

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(${active_color}${opacity})";
        "col.inactive_border" = "rgba(${inactive_color}${opacity})";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 3;
        blur = {
          enabled = true;
	        size = 3;
	        passes = 1;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures.workspace_swipe = "off";
      misc.force_default_wallpaper = -1;

      workspace = "workspace=name:special:term,gapsout:20,on-created-empty:kitty -e tmux new-session \\; split-window -h btop \\; select-pane -L \\;";

      # bindings

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive,"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle
        "$mainMod, W, exec, firefox"
        "$mainMod, T, exec, thunar"
        "$mainMod, F, fullscreen, 1"
        "$mainMod SHIFT, F, fullscreen,"
        "$mainMod ALT, L, exec, ${pkgs.swaylock-effects}/bin/swaylock -C $HOME/.config/swaylock/config"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

	      "$mainMod SHIFT, 1, movetoworkspace, 1"
	      "$mainMod SHIFT, 2, movetoworkspace, 2"
	      "$mainMod SHIFT, 3, movetoworkspace, 3"
	      "$mainMod SHIFT, 4, movetoworkspace, 4"
	      "$mainMod SHIFT, 5, movetoworkspace, 5"
	      "$mainMod SHIFT, 6, movetoworkspace, 6"
	      "$mainMod SHIFT, 7, movetoworkspace, 7"
	      "$mainMod SHIFT, 8, movetoworkspace, 8"
	      "$mainMod SHIFT, 9, movetoworkspace, 9"
	      "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod, B, togglespecialworkspace, term"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    
      bindl = [
        ", XF86MonBrightnessDown, exec, brightnessctl set 1%-" # fn + f2
        ", XF86MonBrightnessUp, exec, brightnessctl set 1%+" # fn + f3

        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-" # fn + f7
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+" # fn + f8
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # fn + f9
      ];
    };
  };
}
