# [[file:../../../README.org::*Installer][Installer:1]]
{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [ ./configuration.nix ];
  users.users.root.openssh.authorizedKeys.keys = lib.mkForce [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1KSX/0Kcoc70rGum3bLz9jXtscpOaV1KNarQ24jPR+"
  ];
}
# Installer:1 ends here
