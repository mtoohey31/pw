{
  description = "poly";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  # TODO: get builds working and create package outputs

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem
    (system: with import nixpkgs { inherit system; }; {
      devShells.default = mkShell {
        packages = [ faust ];
      };
    });
}
