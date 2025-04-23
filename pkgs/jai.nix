{ stdenv, steam-run, makeWrapper }:

# Extract the jai binary in ./jai
stdenv.mkDerivation {
  name = "jai";
  src = ./.;

  nativeBuildInputs = [
    makeWrapper 
  ];
  installPhase = ''
    mkdir -p $out
    cp -r $src/jai $out/jai
    makeWrapper ${steam-run}/bin/steam-run $out/bin/jai --add-flags $out/jai/bin/jai-linux
  '';
}

