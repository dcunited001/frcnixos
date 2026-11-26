# [[file:../../../README.org::*Users][Users:1]]
{ pkgs, ... }: {

  users.groups = {
    dc = {
      name = "dc";
      gid = 1000;
    };
  };

  users.users.dc = {
    uid = 1000;
    group = "dc";
    extraGroups = [
      "wheel"
      "podman"
      "networkmanager"
      "docker"
      "i2c"
      "audio"
      "plugdev"
      "render"
      "video"
    ];
    isNormalUser = true;
    # continue running containers after logout
    linger = true;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAb9WIuASHRVkpqpF5tT5AZoOw5lqlY/ycx1UqsWQH7W"
    ];


    # startUGid = (1000000 + (n * lib.custom.pow (2 16)));
    subUidRanges = [
      {
        startUid = 1000000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 1000000;
        count = 65536;
      }
    ];
  };

}
# Users:1 ends here
