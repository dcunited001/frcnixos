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
    grub.enable = false;
    systemd-boot.enable = false;
  };
in
{              
  disko.devices.disk.main = {
    device = "/dev/disk/by-id/mmc-A3V014_0xb10b87f2";
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
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
# Original Install:1 ends here
