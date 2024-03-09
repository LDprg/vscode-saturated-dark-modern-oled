{
  inputs = { nixpkgs.url = "nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      supportedSystems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      pkgs = forAllSystems (system: import nixpkgs { inherit system; });

    in {

      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShell {
          nativeBuildInputs = with pkgs.${system}; [ vsce nodejs_21 bun ];
        };
      });
    };
}
