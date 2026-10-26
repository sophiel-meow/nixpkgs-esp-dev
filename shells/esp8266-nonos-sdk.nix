{
  pkgs ? import <nixpkgs> {
    overlays = [ (import ../overlay.nix) ];
  },
}:

pkgs.mkShell {
  name = "esp8266-nonos-sdk-shell";

  buildInputs = with pkgs; [
    esp8266-nonos-sdk
  ];
}
