{
  pkgs ? import <nixpkgs> {
    overlays = [ (import ../overlay.nix) ];
  },
}:

pkgs.mkShell {
  name = "esp-idf-xtensa-shell";

  buildInputs = with pkgs; [
    esp-idf-xtensa
  ];
}
