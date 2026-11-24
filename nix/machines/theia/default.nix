# [[file:../../../README.org::*Original Install][Original Install:1]]
{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  boot-loader-systemd = {
    grub.enable = lib.mkForce false;
    systemd-boot = {
      enable = true;
      installDeviceTree = true;
    };
    efi.canTouchEfiVariables = false;
  };
  boot-loader-u-boot = {
    grub.enable = false; # mkForce
    systemd-boot.enable = false;
  };
in
{
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAb9WIuASHRVkpqpF5tT5AZoOw5lqlY/ycx1UqsWQH7W openpgp:0xBECF991C"
  ];

  # i2c
  services.ddccontrol.enable = true;
  boot.kernelModules = [ "i2c_dev" ];
  users.groups.i2c = { };
}
# Original Install:1 ends here
