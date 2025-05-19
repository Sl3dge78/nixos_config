{outputs, inputs, config, lib, pkgs, ...} :

{

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    waybar
    dunst
    libnotify
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    hyprpaper
  ];
}
