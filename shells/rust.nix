{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    clang
    llvmPackages.bintools
    rustup
    rustfmt
    trunk
    rustc-wasm32
    dioxus-cli
  ];
}
