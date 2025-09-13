# This file defines overlays/custom modifications to upstream packages
#

{ inputs, ... }:

let
  # overlays that are merely custom mackages
  additions = final: prev:
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs/common;
    });

  linuxModifications = final: prev: prev.lib.mkIf final.stdenv.isLinux { };

  # overlays that aren't platform-specific
  # modifications = final: prev: {
  #   # example = prev.example.overrideAttrs (previousAttrs: let ... in {
  #   # ...
  #   # });
  #   hyprland = prev.hyprland.overrideAttrs { mesa = final.unstable.mesa; };
  # };
  #

  # https://discourse.nixos.org/t/intel-ax210-ap-mode/66087/9
  # https://github.com/randomizedcoder/nixos/tree/main/desktop/l2
  # https://tildearrow.org/?p=post&month=7&year=2022&item=lar
  hostapd = final: prev: {
    hostapd = prev.hostapd.overrideDerivation (old: {
      patches = (old.patches or [ ]) ++ [
        (final.fetchpatch {
          url = "https://tildearrow.org/storage/hostapd-2.10-lar.patch";
          #url = "https://github.com/randomizedcoder/tildearrow_hostapd_patch/hostapd-2.10-lar.patch";
          sha256 = "USiHBZH5QcUJfZSxGoFwUefq3ARc4S/KliwUm8SqvoI=";
        })
      ];
    });
  };

  forSystem = final: prev: {
    stable = import inputs.nixpkgs {
      inherit (final) system;
      config.allowUnfree = true;
      # overlays = [];
    };
  };

in {
  # overlays = [ outputs.overlays.default ]
  default = final: prev:
    (additions final prev)
    # // (modifications final prev)
    // (linuxModifications final prev);
  forSystem = final: prev: (forSystem final prev);
  hostapd = final: prev: (hostapd final prev);
}
