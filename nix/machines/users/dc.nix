# [[file:../../../README.org::*Users][Users:2]]
{ pkgs, lib, ... }:
let
  subuidOffset = 1000000;
  userid = 1010;
  pow = lib.fix (
    self: base: power:
    if power != 0 then base * (self base (power - 1)) else 1
  );
in
{
  users.users.dc = {
    uid = userid;
    group = "users";
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

    subUidRanges = [
      {
        startUid = subuidOffset + (uid * (pow (2 16)));
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = subuidOffset + (uid * (pow (2 16)));
        count = 65536;
      }
    ];
  };
}
# Users:2 ends here
