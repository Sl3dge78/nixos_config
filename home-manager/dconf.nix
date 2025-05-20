# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "basic";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "";
      source-units = "degree";
      target-currency = "";
      target-units = "radian";
      window-maximized = true;
      window-size = mkTuple [ 360 (-1) ];
      word-size = 64;
    };

    "org/gnome/desktop/a11y" = {
      always-show-text-caret = false;
    };

    "org/gnome/desktop/a11y/applications" = {
      screen-keyboard-enabled = false;
      screen-reader-enabled = false;
    };

    "org/gnome/desktop/a11y/mouse" = {
      dwell-click-enabled = false;
      dwell-threshold = 10;
      dwell-time = 1.2;
      secondary-click-enabled = false;
      secondary-click-time = 1.2;
    };

    "org/gnome/desktop/interface" = {
      can-change-accels = false;
      clock-show-date = false;
      clock-show-seconds = false;
      color-scheme = "prefer-dark";
      cursor-blink = true;
      cursor-blink-time = 1200;
      cursor-blink-timeout = 10;
      cursor-size = 24;
      cursor-theme = "Bibata-Modern-Classic";
      document-font-name = "Sans 10";
      enable-animations = true;
      font-name = "Ubuntu 10";
      gtk-color-palette = "black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90";
      gtk-color-scheme = "";
      gtk-enable-primary-paste = true;
      gtk-im-module = "";
      gtk-im-preedit-style = "callback";
      gtk-im-status-style = "callback";
      gtk-key-theme = "Default";
      gtk-theme = "Mint-Y-Dark-Aqua";
      gtk-timeout-initial = 200;
      gtk-timeout-repeat = 20;
      icon-theme = "Mint-Y-Dark-Aqua";
      menubar-accel = "F10";
      menubar-detachable = false;
      menus-have-tearoff = false;
      monospace-font-name = "GohuFont 10";
      scaling-factor = mkUint32 0;
      text-scaling-factor = 1.0;
      toolbar-detachable = false;
      toolbar-icons-size = "large";
      toolbar-style = "both-horiz";
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "default";
      double-click = 400;
      drag-threshold = 8;
      left-handed = false;
      middle-click-emulation = false;
      natural-scroll = false;
      speed = 0.0;
    };

    "org/gnome/desktop/privacy" = {
      disable-camera = false;
      disable-microphone = false;
      disable-sound-output = false;
      old-files-age = mkUint32 30;
      recent-files-max-age = 7;
      remember-recent-files = true;
      remove-old-temp-files = false;
      remove-old-trash-files = false;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = false;
      input-feedback-sounds = false;
      theme-name = "LinuxMint";
    };

    "org/gnome/desktop/wm/preferences" = {
      action-double-click-titlebar = "toggle-maximize";
      action-middle-click-titlebar = "lower";
      action-right-click-titlebar = "menu";
      audible-bell = false;
      auto-raise = false;
      auto-raise-delay = 500;
      button-layout = ":minimize,maximize,close";
      disable-workarounds = false;
      focus-mode = "click";
      focus-new-windows = "smart";
      mouse-button-modifier = "<Super>";
      num-workspaces = 4;
      raise-on-click = true;
      resize-with-right-button = true;
      theme = "Mint-Y";
      titlebar-font = "Ubuntu 10";
      titlebar-uses-system-font = false;
      visual-bell = false;
      visual-bell-type = "fullscreen-flash";
      workspace-names = [];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/file-roller/dialogs/extract" = {
      height = 800;
      recreate-folders = true;
      skip-newer = false;
      width = 1000;
    };

    "org/gnome/file-roller/file-selector" = {
      show-hidden = false;
      sidebar-size = 300;
      sort-method = "name";
      sort-type = "ascending";
      window-size = mkTuple [ (-1) (-1) ];
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 407;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 600;
    };

    "org/gnome/nm-applet" = {
      disable-connected-notifications = true;
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 142;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "descending";
      type-format = "category";
      window-position = mkTuple [ 481 287 ];
      window-size = mkTuple [ 957 473 ];
    };

    "org/nemo/desktop" = {
      font = "Ubuntu 10";
    };

    "org/nemo/preferences" = {
      default-folder-viewer = "list-view";
      show-hidden-files = true;
    };

    "org/nemo/window-state" = {
      geometry = "1094x836+90+110";
      maximized = true;
      sidebar-bookmark-breakpoint = 0;
      start-with-sidebar = true;
    };

    "org/x/apps/portal" = {
      color-scheme = "prefer-dark";
    };

    "org/x/editor/plugins" = {
      active-plugins = [ "textsize" "bracketcompletion" "time" "filebrowser" "docinfo" "modelines" "open-uri-context-menu" "joinlines" "sort" "spell" ];
    };

    "org/x/editor/plugins/filebrowser/on-load" = {
      root = "file:///";
      tree-view = true;
      virtual-root = "file:///home/sl3dge/work/test";
    };
  };
}
