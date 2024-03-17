{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    clang
    llvmPackages.bintools
    xorg.libX11.dev
    xorg.libXft.dev
    xorg.libXinerama.dev
    rustup
    rustfmt
    trunk
    rustc-wasm32
    dioxus-cli
    cargo-leptos
    cargo-generate
    tailwindcss
  ];
}
