# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  polybar-spotify = pkgs.callPackage ./polybar-spotify.nix { };
  slippi = pkgs.callPackage ./slippi.nix { };
  altserver = pkgs.callPackage ./altserver.nix { };
  # example = pkgs.callPackage ./example { };
}
