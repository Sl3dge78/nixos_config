# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./hyprland.nix
    ./cinnamon.nix
    ./dconf.nix
    ./nvim.nix
    ./alacritty.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "sl3dge";
    homeDirectory = "/home/sl3dge";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    lazygit
	discord
    alacritty
    git-credential-oauth
    unzip
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "sl3dge78";
    userEmail = "sl3dge78@users.noreply.github.com";
    extraConfig.credential.helper = [ "store" ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  home.file.".config/nixpkgs/config.nix".text = ''
    { 
      allowUnfree = true;
      permittedInsecurePackages = [
          "dotnet-runtime-6.0.36"
      ];
    }
    '';
}
