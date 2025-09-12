{ pkgs, ... }: {
  services.locate.enable = true;
  services.locate = {
    # prunePaths = [ "/tmp" "/var/tmp" "/var/cache" "/var/lock" "/var/run" "/var/spool"
    #   "/nix/store" "/nix/var/log/nix" ];
    # others: /sys /run
    prunePaths = [
      "/afs"
      "/gnu/store"
      "/net"
      "/media"
      "/mnt"
      "/sfs"
      "/tmp"
      "/udev"
      "/root"
      "/proc"
    ];
    pruneBindMounts = true;
    # pruneNames = [ ".bzr" ".cache" ".git" ".hg" ".svn" ];
    # pruneFS = [ "looks good" ];
    # extraFlags = []; # arch doesn't pass anything else
  };
}
