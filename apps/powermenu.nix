{ pkgs ? import <nixpkgs> {}, stdenv ? pkgs.stdenv }:

stdenv.mkDerivation rec {
  pname = "powermenu";
  version = "1.0";
  
  src = fetchGit {
    url = "https://github.com/ozpv/powermenu.git";
    rev = "e5a826b6db2941c992912e940b7da37ae276b144";
  };

  makeFlags = [ "PREFIX=$(out)" "CC=${stdenv.cc.targetPrefix}cc" ];
}
