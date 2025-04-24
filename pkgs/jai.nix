{ stdenv, buildFHSEnv, zlib, sdl3 }:

let 
  pname = "jai";
  version = "0.2.10";
  jai = stdenv.mkDerivation {
    inherit pname version;

    name = "jai";
    src = ./.;

    nativeBuildInputs = [
      # makeWrapper 
    ];
    installPhase = ''
      mkdir -p $out
      cp -r $src/jai $out/jai
      mkdir $out/bin
      ln -s $out/jai/bin/jai-linux $out/bin/jai 
    '';
  };
in
buildFHSEnv {
  name = pname;
  targetPkgs = pkgs: [
    zlib
    jai
    sdl3
  ];
  runScript = "jai";
}
