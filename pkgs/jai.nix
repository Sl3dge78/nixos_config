{
  buildFHSEnv,
  lib,
  requireFile,
  runCommand,
  stdenv,
  unzip,
}:
let
  pname = "jai";
  minor = "2";
  patch = "010";
  version = "0.${minor}.${patch}";
  zipName = "jai-beta-${minor}-${patch}.zip";
  jai = stdenv.mkDerivation {
    name = "jai";
    src = requireFile {
      message = ''
        The language is not yet public. If you are in the closed beta, download the zip file and run the following command:
          nix-store --add-fixed sha256 ${zipName}
      '';
      name = zipName;
      sha256 = "sha256-7S0DFvmiKEvmCT12ukwLu+SSitk4y6BuS6WWCImeOhc=";
    };
    nativeBuildInputs = [ unzip ];
    buildCommand = "unzip $src -d $out";
  };
  meta = {
    description = "General-purpose statically-typed imperative programming language";
    license = lib.licenses.unfree;
    mainProgram = "jai";
    maintainers = with lib.maintainers; [ samestep ];
    platforms = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
in
if stdenv.isLinux then
  buildFHSEnv {
    inherit meta pname version;
    targetPkgs = pkgs: [ pkgs.zlib ];
    runScript = "${jai}/jai/bin/jai-linux";
  }
else
  runCommand "jai" { inherit meta pname version; } ''
    mkdir -p $out/bin
    ln -s ${jai}/jai/bin/jai-macos $out/bin/jai
  ''
