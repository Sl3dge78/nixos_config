# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixpkgs.config.allowUnfree = true;
  # jai = pkgs.callPackage ./jai.nix { };
  jai-vim = pkgs.callPackage ./jai-vim.nix {};
}
