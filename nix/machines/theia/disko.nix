# [[file:../../../README.org::*Disko][Disko:1]]
{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  rootPartitionUUID = "12345678-0ae0-484d-9d54-1234567890ab";
in
{
  disko.devices.disk.main = {
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
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          size = "192G";
          uuid = rootPartitionUUID;
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ]; # Override existing partition
            subvolumes = {
              "/@" = {
                mountpoint = "/";
                mountOptions = [
                  "compress=zstd"
                ];
              };
              "/@/home" = {
                mountpoint = "/home";
                mountOptions = [
                  "compress=zstd"
                ];
              };
              "/@/nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
              "/@/var" = {
                mountpoint = "/var";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
              "/@/var/cache" = {
                mountpoint = "/var/cache";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
              "/@/var/tmp" = {
                mountpoint = "/var/tmp";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
              "/@/var/log" = {
                mountpoint = "/var/log";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
              "/@/gnu" = {
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
                mountpoint = "/gnu";
              };
              "/@/swap" = {
                mountpoint = "/.swapvol";
                swap = {
                  swapfile.size = "64M";
                  swapfile2.size = "64M";
                  swapfile2.path = "rel-path";
                };
              };
            };
          };
        };
      };
    };
  };

  disko.devices.disk.emmc = {
    device = "/dev/disk/by-id/mmc-A3V014_0xb10b87f2";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        data = {
          size = "128G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/data";
          };
        };
      };
    };
  };
}
# Disko:1 ends here
