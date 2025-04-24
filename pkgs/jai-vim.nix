{ vimUtils, fetchFromGitHub }:
vimUtils.buildVimPlugin {
  pname = "jai-vim";
  version = "";
  src = fetchFromGitHub { 
    owner = "rluba";
    repo = "jai.vim";
    rev = "72c09c5f803b8ab2e708a3ad2b7c3704e2b4b3d8";
    sha256 = "sha256-usCZGQzlt4FDrEu+6/ViPbXoh8OzNOOJmvWAyMVUhkY=";
  };
}
