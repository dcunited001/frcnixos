# [[file:../../../README.org::*Vendor][Vendor:1]]
{ lib, config, pkgs, ... }: let
  rootPartitionUUID = "14e19a7b-0ae0-484d-9d54-43bd6fdc20c7";
in
{
  boot = {
    kernelParams = [
      "root=UUID=${rootPartitionUUID}"
      "rootfstype=btrfs"
    ];
    consoleLogLevel = 7;

    loader = {
      grub.enable = lib.mkForce false;
      generic-extlinux-compatible.enable = lib.mkForce true;
    };
  };

  # TODO: how to specify u-boot here
}
# Vendor:1 ends here
