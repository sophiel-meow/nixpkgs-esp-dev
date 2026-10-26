{
  pkgs ? import <nixpkgs> {
    overlays = [ (import ../overlay.nix) ];
  },
}:

pkgs.mkShell {
  name = "esp-idf-riscv-shell";

  buildInputs = with pkgs; [
    esp-idf-riscv
  ];
}
