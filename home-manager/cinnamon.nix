{ lib, ... }:

with lib.hm.gvariant;
{
  dconf.settings = {
    "org/cinnamon" = {
      alttab-switcher-delay = 100;
      enabled-applets = [ "panel1:left:0:menu@cinnamon.org:0" "panel1:left:1:separator@cinnamon.org:1" "panel1:right:1:systray@cinnamon.org:3" "panel1:right:2:xapp-status@cinnamon.org:4" "panel1:right:3:notifications@cinnamon.org:5" "panel1:right:6:keyboard@cinnamon.org:8" "panel1:right:8:network@cinnamon.org:10" "panel1:right:9:sound@cinnamon.org:11" "panel1:right:11:calendar@cinnamon.org:13" "panel1:right:12:cornerbar@cinnamon.org:14" "panel1:left:2:window-list@cinnamon.org:15" "panel2:right:1:calendar@cinnamon.org:16" "panel2:left:0:window-list@cinnamon.org:17" ];
      next-applet-id = 18;
      panel-edit-mode = false;
      panel-zone-icon-sizes = "[{\"panelId\":1,\"left\":0,\"center\":0,\"right\":24},{\"left\":0,\"center\":0,\"right\":0,\"panelId\":2}]";
      panel-zone-symbolic-icon-sizes = "[{\"panelId\":1,\"left\":28,\"center\":28,\"right\":16},{\"left\":28,\"center\":28,\"right\":28,\"panelId\":2}]";
      panel-zone-text-sizes = "[{\"panelId\":1,\"left\":0,\"center\":0,\"right\":0},{\"left\":0,\"center\":0,\"right\":0,\"panelId\":2}]";
      panels-autohide = [ "1:false" "2:false" ];
      panels-enabled = [ "1:0:top" "2:1:top" ];
      panels-height = [ "1:20" "2:20" ];
      panels-hide-delay = [ "1:0" "2:0" ];
      panels-show-delay = [ "1:0" "2:0" ];
      window-effect-speed = 2;
    };

    "org/cinnamon/cinnamon-session" = {
      quit-time-delay = 60;
    };

    "org/cinnamon/desktop/applications/calculator" = {
      exec = "gnome-calculator";
    };

    "org/cinnamon/desktop/applications/terminal" = {
      exec = "alacritty";
      exec-arg = "";
    };

    "org/cinnamon/desktop/background" = {
      picture-uri = "file:///home/sl3dge/Pictures/wallpapers/bush.png";
    };

    "org/cinnamon/desktop/background/slideshow" = {
      delay = 15;
      image-source = "directory:///home/sl3dge/Pictures/wallpapers";
    };

    "org/cinnamon/desktop/interface" = {
      cursor-blink-time = 1200;
      cursor-theme = "Bibata-Modern-Classic";
      font-name = "Ubuntu 10";
      gtk-overlay-scrollbars = true;
      gtk-theme = "Mint-Y-Dark-Aqua";
      icon-theme = "Mint-Y-Sand";
      monospace-font-name = "GohuFont 10";
      text-scaling-factor = 1.0;
    };

    "org/cinnamon/desktop/keybindings/wm" = {
      maximize = [];
      move-to-workspace-1 = "<Shift><Super>1";
      move-to-workspace-2 = "<Shift><Super>at";
      move-to-workspace-3 = "<Shift><Super>numbersign";
      move-to-workspace-4 = "<Shift><Super>dollar";
      move-to-workspace-5 = "<Shift><Super>percent";
      move-to-workspace-6 = "<Shift><Super>asciicircum";
      move-to-workspace-7 = "<Shift><Super>ampersand";
      move-to-workspace-8 = "<Shift><Super>asterisk";
      move-to-workspace-9 = "<Shift><Super>parenleft";
      move-to-workspace-10 = "<Shift><Super>parenright";
      switch-to-workspace-1 = "<Super>1";
      switch-to-workspace-2 = "<Super>2";
      switch-to-workspace-3 = "<Super>3";
      switch-to-workspace-4 = "<Super>4";
      switch-to-workspace-5 = "<Super>5";
      switch-to-workspace-6 = "<Super>6";
      switch-to-workspace-7 = "<Super>7";
      switch-to-workspace-8 = "<Super>8";
      switch-to-workspace-9 = "<Super>9";
      switch-to-workspace-10 = "<Super>10";
    };

    "org/cinnamon/desktop/media-handling" = {
      autorun-never = false;
    };

    "org/cinnamon/desktop/notifications" = {
      notification-duration = 4;
    };

    "org/cinnamon/desktop/peripherals/keyboard" = {
      delay = mkUint32 500;
      numlock-state = true;
      repeat-interval = mkUint32 30;
    };

    "org/cinnamon/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/cinnamon/desktop/sound" = {
      event-sounds = false;
    };

    "org/cinnamon/desktop/wm/preferences" = {
      min-window-opacity = 30;
      mouse-button-modifier = "<Super>";
      titlebar-font = "Ubuntu 10";
    };

    "org/cinnamon/gestures" = {
      swipe-down-2 = "PUSH_TILE_DOWN::end";
      swipe-down-3 = "TOGGLE_OVERVIEW::end";
      swipe-down-4 = "VOLUME_DOWN::end";
      swipe-left-2 = "PUSH_TILE_LEFT::end";
      swipe-left-3 = "WORKSPACE_NEXT::end";
      swipe-left-4 = "WINDOW_WORKSPACE_PREVIOUS::end";
      swipe-right-2 = "PUSH_TILE_RIGHT::end";
      swipe-right-3 = "WORKSPACE_PREVIOUS::end";
      swipe-right-4 = "WINDOW_WORKSPACE_NEXT::end";
      swipe-up-2 = "PUSH_TILE_UP::end";
      swipe-up-3 = "TOGGLE_EXPO::end";
      swipe-up-4 = "VOLUME_UP::end";
      tap-3 = "MEDIA_PLAY_PAUSE::end";
    };

    "org/cinnamon/launcher" = {
      check-frequency = 300;
      memory-limit = 2048;
    };

    "org/cinnamon/muffin" = {
      draggable-border-width = 10;
    };

    "org/cinnamon/settings-daemon/peripherals/keyboard" = {
      numlock-state = "on";
    };

    "org/cinnamon/sounds" = {
      login-enabled = false;
      logout-enabled = false;
      notification-enabled = false;
      plug-enabled = false;
      switch-enabled = false;
      tile-enabled = false;
      unplug-enabled = false;
    };

    "org/cinnamon/theme" = {
      name = "Mint-Y-Dark-Aqua";
    };
  };
}

