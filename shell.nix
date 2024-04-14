
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    git
    neovim
    ripgrep # telescope - better fuzzy finder
    fd # telescope - better file finder
    gcc # treesitter - compiling parsers
  ];
}
