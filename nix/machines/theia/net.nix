# [[file:../../../README.org::*Networking][Networking:1]]
{ pkgs, config, ...}:
{
  networking.useDHCP = true;
  networking.networkmanager.enable = true;
  networking.networkmanager = {
    dns = "systemd-resolved";
  };

  services.resolved.enable = true;
  services.resolved = {
    settings.Resolve.DNS = config.networking.nameservers;
  };

  services.avahi.enable = true;
  services.avahi.publish.enable = true;

  programs.mtr.enable = true;
  programs.tcpdump.enable = true;
}
# Networking:1 ends here
