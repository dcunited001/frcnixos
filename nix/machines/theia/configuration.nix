# [[file:../../../README.org::*OrangePi][OrangePi:1]]
{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  networking.hostName = "theia";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  hardware.enableRedistributableFirmware = true;

  services.speechd.enable = false; # too many deps
}
# OrangePi:1 ends here
