# [[file:../../README.org::*Nix][Nix:1]]
{ pkgs,...  }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
};
# Nix:1 ends here
