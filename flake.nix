{
  description = "A Flake to store my config assets";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in {
      homeManagerModules.default = import ./home.nix self;

      devShells.${system}.default = pkgs.mkShell {
        NIX_CONFIG = "extra-experimental-features = nix-command flakes";
        nativeBuildInputs = with pkgs; [
          nix
          home-manager
          git

          nixd
          nixfmt-classic
          statix
        ];
      };
    };
}
