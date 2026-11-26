# [[file:../../README.org::*Serial][Serial:1]]
{ ... }:
{
  # i2c
  services.ddccontrol.enable = true;
  boot.kernelModules = [ "i2c_dev" ];
  users.groups.i2c = { };
}
# Serial:1 ends here
