# [[file:../../../README.org::*Upstream][Upstream:2]]
{ lib, pkgs, ... }: {

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = {
      zfs = lib.mkForce false; # nixos-rk3588 disables ZFS (kernel versioning constraints)
    };

    kernelParams = lib.mkBefore [
      "rootwait"

      # TODO: got a warning for this arg
      "earlycon" # enable early console, so we can see the boot messages via serial port / HDMI
      "consoleblank=0" # disable console blanking(screen saver)
      "console=ttyS2,1500000" # serial port
      "console=tty1" # HDMI

      # from vendor sdImage in nixos-rk3588.nix
      "cgroup_enable=cpuset"
      "cgroup_memory=1"
      "cgroup_enable=memory"
      "swapaccount=1"
    ];
  };
}
# Upstream:2 ends here
