{ config, pkgs, inputs, ... }:
let
  opacity = "0.5";
  fontSize = "12";
  iconSize = "16";
  palette = {
    font = "Symbols Nerd fonts, monospace";
    fontsize = fontSize;
    iconsize = iconSize;
    primary_accent = "cba6f7";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "282c34";

    primary_accent_hex = "cba6f7";
    secondary_accent_hex = "89b4fa";
    tertiary_accent_hex = "f5f5f5";
    primary_background_hex = "11111B";
    secondary_background_hex = "1b1b2b";
    tertiary_background_hex = "21252b";

    primary_accent_rgba = "rgba(203, 166, 247, ${opacity})";
    secondary_accent_rgba = "rgba(137, 180, 250, ${opacity})";
    tertiary_accent_rgba = "rgba(245, 245, 245, ${opacity})";
    primary_background_rgba = "rgba(40, 44, 52, ${opacity})";
    secondary_background_rgba = "rgba(40, 44, 52, ${opacity})";
    tertiary_background_rgba = "rgba(33, 37, 43, ${opacity})";

    critical = "rgba(227, 16, 16, 1.0)";

    button_active_color = "b117c3";
  };
  playerctl = "${pkgs.playerctl}/bin/playerctl";
in {
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      mod = "dock";
      # set margins
      margin-top = 0;
      margin-bottom = 2;
      margin-left = 0;
      margin-right = 0;
      # module used in waybar
      modules-left = [
        "backlight"
        "pulseaudio"
        "pulseaudio#microphone"
        "custom/playerlabel"
        "custom/wlinhibit"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "tray"
        "network"
    	  "battery"
	      "cpu"
	      "temperature"
	      "memory"
        "user"
        "clock"
      ];
      # backlight settings
      backlight = {
        device = "intel_backlight";
        format = "{icon} {percent}%";
        format-icons = ["" ""];
        min-length = 6;
        on-scroll-down = "brightnessctl set 1%-";
        on-scroll-up = "brightnessctl set 1%+";
      };
      # pulseaudio settings
      pulseaudio = {
        format = "{icon} {volume}%";
        format-icons = {
          car = "";
          default = ["" "" ""];
          hands-free = "";
          headphone = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " Muted";
        on-click = "pamixer -t";
        on-scroll-down = "pamixer -d 5";
        on-scroll-up = "pamixer -i 5";
        scroll-step = 5;
        # tooltip = false;
      };
      # pulseaudio microphone settings
      "pulseaudio#microphone" = {
        format = "{format_source}";
        format-source = " {volume}%";
        format-source-muted = "  Muted";
        on-click = "pamixer --default-source -t";
        on-scroll-down = "pamixer --default-source -d 5";
        on-scroll-up = "pamixer --default-source -i 5";
        scroll-step = 5;
      };
      # playerctl
      "custom/playerlabel" = {
        format = "<span>󰎈 {} 󰎈</span>";
        return-type = "json";
        max-length = 25;
        exec = "${playerctl} -a metadata --format '{\"text\": \"{{markup_escape(title)}} - {{artist}}\", \"tooltip\": \"{{markup_escape(title)}} - {{artist}} ({{playerName}})\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "";
      };
      # wlinhibit
      "custom/wlinhibit" = {
        tooltip = false;
        exec = "waybar-wlinhibit";
        return-type = "json";
        restart-interval = 3;
        on-click = "killall wlinhibit || wlinhibit";
      };
      # hyprland workspace settings
      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = true;
        disable-scroll = true;
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          urgent = "";
          active = "";
          default = "";
          sort-by-number = true;
        };
        persistent_workspaces = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          "8" = "";
          "9" = "";
          "10" = "";
        };

      };
      # hyprland window settings
      "hyprland/window" = {
        format = "<span font=${palette.fontsize} rise='-4444'>{}</span>";
        max-length = 200;
        separate-outputs = true;
      };
      # tray settings
      tray = {
        icon-size = palette.iconsize;
        spacing = 10;
      };
      # bluetooth settings
      bluetooth = {
        format = "";
        format-disabled = "󰂲";
        format-connected = " {num_connections} connected";
        tooltip-format = "{controller_alias}\t{controller_address}";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        on-click = "rofi-bluetooth";
        on-click-right = "bluetooth toggle";
      };
      # network settings
      network = {
        format-wifi = " {signalStrength}%";
        format-ethernet = "󰈀 ";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "󰖪 ";
        tooltip-format-disconnected = "󰖪 Disconnected";
        tooltip-format = " {essid} ({signalStrength}%)";
      };
      # battery settings
      battery = {
        format = "{icon} {capacity}%";
        format-alt = "{time} {icon}";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        states = {
	      good = 100;
	      warning = 25;
	      critical = 15;
	    };
      };
      # cpu settings
      cpu = {
        format = " {usage:>2}%";
        interval = 1;
      };
      # temperature settings
      temperature = {
        format = " {temperatureC}°C";
        format-critical = " {temperatureC}°C";
        critical-threshold = 60;
        hwmon-path = [
          "/sys/class/hwmon/hwmon2/temp1_input"
          "/sys/class/thermal/thermal_zone0/temp"
        ];
        thermal-zone = 2;
      };
      # memory settings
      memory = {
        format = " {used:0.1f}G/{total:0.1f}G";
        interval = 30;
      };
      # user/uptime settings
      user = {
        format = "🐢 up {work_H}:{work_M}";
      };
      # clock settings
      clock = {
        format = " {:%R  %d.%m.}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	    tooltip = true;
      };
    };
    # styling
    style = ''
      * {
        border: none;
        border-radius: 0px;
        font-family: ${palette.font};
        font-size: ${palette.fontsize};
        min-height: 25px;
      }

      window#waybar {
        background: ${palette.primary_background_rgba};
        color: #${palette.primary_accent};
      }

      tooltip {
        background: #${palette.primary_background_hex};
        border-radius: 10px;
        border-width: 2px;
	    border-style: solid;
	    border-color: #${palette.secondary_background_hex};
      }

      #backlight {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 5px;
  	    font-weight: bold;
      }

      #pulseaudio {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 0px 2px 5px;
  	    font-weight: bold;
      }

      #pulseaudio.microphone {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 5px 2px 0px;
  	    font-weight: bold;
      }

      #custom-playerlabel {
        color: #${palette.tertiary_accent};
        padding: 0px 20px;
        margin: 5px 0px;
        font-weight: bold;
      }

      #custom-wlinhibit {
        color: #${palette.tertiary_accent};
        padding: 0px 20px;
        margin: 5px 0px;
        font-weight: bold;
      }

      #workspaces {
        color: #${palette.primary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 5px;
      }
	  
      #workspaces button {
        padding: 0px 5px;
        border-radius: 16px;
  	    transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
        background-color: #${palette.secondary_accent};
        color: #${palette.background};
        border-radius: 16px;
        min-width: 50px;
        background-size: 400% 400%;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
        background-color: #${palette.tertiary_accent};
        color: #${palette.background};
        border-radius: 16px;
        min-width: 50px;
        background-size: 400% 400%;
        font-weight: bold;
      }

      #tray {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 5px;
  	    font-weight: bold;
      }

      #network, #battery {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 5px;
        font-weight: bold;
      }

      #battery.good:not(.charging) {
        color: #3aa103;
      }

      #battery.warning:not(.charging) {
        color: #f58207;
      }

      #battery.critical:not(.charging) {
        color: ${palette.critical};
      }

      #battery.charging {
        color: #036bfc;
      }

      #cpu {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 0px 2px 5px;
	    font-weight: bold;
      }

      #temperature {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 0px;
  	    font-weight: bold;
      }

      #temperature.critical {
        color: ${palette.critical};
      }

      #memory {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 5px 2px 0px;
  	    font-weight: bold;
      }

      #user {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 2px;
        margin: 2px 0px 2px 5px;
        font-weight: bold;
      }

      #clock {
        color: #${palette.tertiary_accent};
        padding: 0px 8px 0px 8px;
        margin: 2px 5px 2px 0px;
        font-weight: bold;
      }
    '';
  };
}
