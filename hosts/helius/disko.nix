# USAGE in your configuration.nix.
# Update devices to match your hardware.
# {
#   imports = [ ./disko-config.nix ];
#   disko.devices.disk.root.device = "/dev/sda";
#   disko.devices.disk.data1.device = "/dev/sdb";
#   disko.devices.disk.data2.device = "/dev/sdc";
# }

{ lib, disk ? "/dev/vda", withSwap ? false, swapSize, ... }:
let
  diskoHostname = "helius";
  diskoDisk = "/dev/nvme0n1";
in {
  disko.devices = {
    disk.main = {
      type = "disk";
      device = disk;
      content = {
        type = "gpt";
        partitions = {
          esp = {
            priority = 1;
            name = "${diskoHostname}ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" "fmask=0022" "dmask=0022" ];
            };
          };

          root = {
            # Subvolumes must set a mountpoint in order to be mounted,
            # unless their parent is mounted
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # force overwrite
              subvolumes = {
                "@root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@root/var" = {
                  mountpoint = "/var";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@root/var/log" = {
                  mountpoint = "/var/log";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@root/var/cache" = {
                  mountpoint = "/var/cache";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@root/var/tmp" = {
                  mountpoint = "/var/tmp";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "noatime" ];
                };
                "@swap" = lib.mkIf withSwap {
                  mountpoint = "/.swapvol";
                  swap.swapfile.size = "${swapSize}G";
                };
              };
            };
          };

          home = {
            # Subvolumes must set a mountpoint in order to be mounted,
            # unless their parent is mounted
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # force overwrite
              subvolumes = {
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "defaults"
                    "noatime"
                    "compress=zstd"
                    "discard=async"
                    "ssd"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
