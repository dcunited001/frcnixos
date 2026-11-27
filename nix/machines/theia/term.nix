# [[file:../../../README.org::*Terminal][Terminal:1]]
{ pkgs,...  }:
{
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableLsColors = true;
    enableCompletion = true;
  };

  programs.bash = {
    completion.enable = true;
  };

  programs.git = {
    enable = true;
    prompt.enable = true;
    lfs.enable = true;
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  console = {
    font = "Lat2-Terminus16";
  };

  services.gpm.enable = true;
}
# Terminal:1 ends here
