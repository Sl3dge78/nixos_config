{ pkgs, home, inputs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    rofi-wayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = null;
    settings = {
      monitor = [ "DVI-D-1, 1920x1080, 0x0, 1" "HDMI-A-1, 1920x1080, 1920x0, 1"];
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
      "$menu" = "rofi -show run";
      exec-once = ["waybar & dunst" "hyprpaper"];
      env = [ "HYPRCURSOR_THEME,rose-pine-hyprcursor" "XCURSOR_SIZE,24" ];
      general = {
        gaps_in = 1;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgba(d65d0eee) rgba(ebdbb2ee) 45deg";
        "col.inactive_border" = "rgba(282828aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 5;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = "yes";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };
      misc = {
        force_default_wallpaper = 2;
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
      };

      input = {
        numlock_by_default = true;
        kb_layout = "us";
        kb_variant = "altgr-intl";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        touchpad = {
          natural_scroll = false;
        };
      };
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

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

        "$mainMod CTRL, left, movecurrentworkspacetomonitor, l"
        "$mainMod CTRL, right, movecurrentworkspacetomonitor, r"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "opacity 0.9 override 0.9 override, class:Alacritty"
        "opacity 0.8 override 0.8 override, onworkspace:s[true]"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "bottom";
        position = "top";
        reload_style_on_change = true;
        height = 10;
        modules-left = ["custom/notification" "tray"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["group/expand" "pulseaudio" "clock"];
        "hyprland/workspaces" = {
          format = "{icon}";
          "format-icons" = {
            active = "";
            default = "";
            empty = "";
          };
          "persistent-workspaces" = {
            "*"= [ 1 2 3 4 5 ];
          };
        };
        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
        interval = 5;
        format = " {usage:2}%";
        tooltip = true;
        };
        "disk" = {
        format = " {free}";
        tooltip = true;
        };
        "custom/expand"= {
          "format" = "";
          "tooltip" = false;
        };
        "group/expand" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 600;
            "transition-to-left" = true;
            "click-to-reveal" = true;
          };
          "modules" = ["custom/expand" "cpu" "memory" "temperature" "network" "custom/endpoint"];
        };
        "clock"= {
            format = "{:%Y-%m-%d - %H:%M}";
            interval = 1;
            tooltip-format= "<tt>{calendar}</tt>";
            calendar = {
                format = {
                    today = "<span color='#fAfBfC'><b>{}</b></span>";
                };
            };
            actions = {
                "on-click-right" = "shift_down";
                "on-click" = "shift_up";
            };
        };
        "network" = {
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "{icon} {format_source}";
          format-muted = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "tray"= {
            "icon-size" = 14;
            "spacing" = 10;
        };
      }

    ];
    style = ''
      * {
        font-family : "GohuFont 14 Nerd Font Mono, Font Awesome";
        font-size: 12;
      }
      window#waybar{
          all:unset;
      }
      .modules-left {
          padding:5px;
          margin:5 0 5 10;
          border-radius:10px;
          background: alpha(#282828,.6);
          box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }
      .modules-center {
          padding:5px;
          margin:5 0 5 0;
          border-radius:10px;
          background: alpha(#282828,.6);
          box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }
      .modules-right {
          padding:5px;
          margin: 5 5 5 0;
          border-radius:10px;
          background: alpha(#282828,.6);
          box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }
      tooltip {
          background:#282828;
          color: #8ec07c;
      }
#clock:hover, #custom-pacman:hover, #custom-notification:hover,#bluetooth:hover,#network:hover,#battery:hover, #cpu:hover,#memory:hover,#temperature:hover{
          transition: all .3s ease;
          color:#83a598;
      }
#custom-notification {
          padding: 0px 10px;
          transition: all .3s ease;
          color:#8ec07c;
      }
#clock{
          padding: 0px 10px;
          color:#ebdbb2;
          transition: all .3s ease;
      }
#pulseaudio {
          padding: 0px 10px;
          color:#98971a;
          transition: all .3s ease;
      }
#custom-pacman{
          padding: 0px 5px;
          transition: all .3s ease;
          color:#8ec07c;

      }
#workspaces {
          padding: 0px 5px;
      }
#workspaces button {
          all:unset;
          padding: 0px 5px;
          color: alpha(#83a598,.4);
          transition: all .2s ease;
      }
#workspaces button:hover {
          color:rgba(0,0,0,0);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
          transition: all 1s ease;
      }
#workspaces button.active {
          color: #83a598;
          border: none;
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }
#workspaces button.empty {
          color: rgba(0,0,0,0);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
      }
#workspaces button.empty:hover {
          color: rgba(0,0,0,0);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
          transition: all 1s ease;
      }
#workspaces button.empty.active {
          color: #83a598;
          border: none;
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }
#bluetooth{
          padding: 0px 10px;
          transition: all .3s ease;
          color:#8ec07c;

      }
#network{
          padding: 0px 5px;
          transition: all .3s ease;
          color:#8ec07c;

      }
#battery{
          padding: 0px 10px;
          transition: all .3s ease;
          color:#8ec07c;


      }
#battery.charging {
          color: #26A65B;
      }

#battery.warning:not(.charging) {
          color: #ffbe61;
      }

#battery.critical:not(.charging) {
          color: #f53c3c;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      #group-expand{
          padding: 0px 10px;
          transition: all .3s ease; 
      }
      #custom-expand{
          padding: 0px 10px;
          color:alpha(#ebdbb2,.2);
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .7);
          transition: all .3s ease; 
      }
      #custom-expand:hover{
          color:rgba(255,255,255,.2);
          text-shadow: 0px 0px 2px rgba(255, 255, 255, .5);
      }
      #custom-colorpicker{
          padding: 0px 10px;
      }
      #cpu,#memory,#temperature{
          padding: 0px 5px;
          transition: all .3s ease; 
        }
      #cpu {
          color:#458588;
      }
      #memory {
          color:#d79921;
      }
      #temperature {
          color:#cc241d;
      }
      #custom-endpoint{
          color:transparent;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);
      }
      #tray{
          padding: 0px 5px;
          transition: all .3s ease; 

      }
      #tray menu * {
          padding: 0px 5px;
          transition: all .3s ease; 
      }

      #tray menu separator {
          padding: 0px 5px;
          transition: all .3s ease; 
      }
    '';
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/Pictures/wallpapers/bush.png" ];
      wallpaper = [ ",~/Pictures/wallpapers/bush.png"];
    };
  };

  home.file.".config/rofi/config.rasi".text = ''
/* ROFI SQUARED THEME USING THE EVERFOREST PALETTE  */
/* Author: Newman Sanchez (https://github.com/newmanls) */

* {
    font:   "GohuFont 11 Nerd Font Mono";

    bg0:     #282828;
    bg1:     #3c3836;
    fg0:     #dbdbb2;

    selected-color:   #458588;
    accent-color:     #d65d0e;
    urgent-color:     #d79921;

    background-color:   transparent;
    text-color:         @fg0;

    margin:     0;
    padding:    0;
    spacing:    0;
}

window {
    location:   north;
    width:      200;

    background-color:   @bg0;
    border: 1px;
    border-color: @bg1;
    border-radius: 5px;
}

inputbar {
    spacing:    5px;
    padding:    5px;

    background-color:   @bg1;
    text-color: @fg0;
}

prompt, entry, element-icon, element-text {
    vertical-align: 0.5;
    text-color: @fg0;
}

prompt {
    text-color: @accent-color;
}

entry {
    placeholder: "";
    cursor-width: 1px;
    cursor-color: @fg0;
}

textbox {
    padding:            8px;
    background-color:   @bg1;
    text-color: @accent-color;
}

listview {
    padding:    0px 0;
    lines:      8;
    columns:    1;
    scrollbar: false;

    fixed-height:   false;
}

element {
    padding:    2px;
    spacing:    1px;
}

element normal normal {
    text-color: @fg0;
    background-color : @bg0;
}

element normal urgent {
    text-color: @urgent-color;
}

element normal active {
    text-color: @selected-color;
}

element alternate active {
    text-color: @selected-color;
}

element alternate normal {
    background-color : @bg1;
    text-color : @fg0;
}

element selected {
    text-color: @fg0;
}

element selected normal, element selected active {
    background-color:   @selected-color;
}

element selected urgent {
    background-color:   @urgent-color;
}

element-icon {
    size:   0.8em;
}

element-text {
    text-color: inherit;
}
  '';

}
