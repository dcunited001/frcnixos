# [[file:../../../README.org::*OrangePi][OrangePi:1]]
{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # i2c
  services.ddccontrol.enable = true;
  boot.kernelModules = [ "i2c_dev" ];
  users.groups.i2c = { };

  kernelParams = [
    "root=UUID=${rootPartitionUUID}" # must override this
    "rootfstype=btrfs"
  ];

  networking.hostName = "theia";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  hardware.enableRedistributableFirmware = true;

  services.speechd.enable = false; # too many deps
}
# OrangePi:1 ends here
