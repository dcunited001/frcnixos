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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgQVDli1owQsEXoQ/94sp8Dm87S4mONeBf5DArT/V+i"
  ];

  # i2c
  services.ddccontrol.enable = true;
  boot.kernelModules = [ "i2c_dev" ];
  users.groups.i2c = { };
}
# Original Install:1 ends here
