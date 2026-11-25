# [[file:../../README.org::*Serial][Serial:1]]
{ ... }:
{
  # i2c
  services.ddccontrol.enable = true;
  boot.kernelModules = [ "i2c_dev" ];
  services.ddccontrol.enable = true;
  users.groups.i2c = { };
}
# Serial:1 ends here
