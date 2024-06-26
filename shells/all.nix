{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    clang
    llvmPackages.bintools
    xorg.libX11.dev
    xorg.libXft.dev
    xorg.libXinerama.dev
    rustc
    rustup
    rust-analyzer
    rustfmt
    trunk
    rustc-wasm32
    dioxus-cli
    cargo
    cargo-binutils
    cargo-leptos
    cargo-generate
    tailwindcss
    binaryen
    postgresql
    sqlx-cli
  ];
}
