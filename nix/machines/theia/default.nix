# [[file:../../../README.org::*Original Install][Original Install:1]]
{...}:

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

  disko.devices.disk.main = {
    # device = "/dev/disk/by-id/mmc-A3V014_0xb10b87f2";
    device = "/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b4128b292";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        root = {
          size = "30%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };

  # i2c
  services.ddccontrol.enable = true;
  boot.kernelModules = [ "i2c_dev" ];
  users.groups.i2c = { };
}
# Original Install:1 ends here
