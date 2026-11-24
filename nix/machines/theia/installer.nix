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
    config.secretspec.secrets.MACH_INSTALL_PUB
  ];
}
# Installer:1 ends here
