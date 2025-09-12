{ config, inputs, outputs, lib, pkgs, ... }:

{
  imports = lib.flatten [
    ./hardware.nix
    # "./disko.nix"
    ./containers.nix

    inputs.disko.nixosModules.disko
    ./disko.nix
    {
      _module.args = {
        disk = "/dev/vda";
        withSwap = true;
        swapSize = 4; # not enough to hibernate
      };
    }

    (map lib.custom.relativeToRoot [
      "modules/desktop/appimage.nix"
      "modules/desktop/bluetooth.nix"
      "modules/desktop/fonts.nix"
      "modules/desktop/docs.nix"
      "modules/desktop/pipewire.nix"
      "modules/desktop/xdg.nix"

      "modules/programs/gnupg.nix"

      "modules/services/gnome.nix"
      "modules/services/locate.nix"
      "modules/services/nix.nix"
      "modules/services/openssh.nix"
      "modules/services/ras.nix"
      "modules/services/smartd.nix"
      "modules/services/yubikey.nix"

      "modules/users/frc.nix"
    ])
  ];

  # nixpkgs.unstable.config.allowUnfree = true;
  users.defaultUserShell = pkgs.bash;

  # ---------------------------------------------
  # Boot

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    systemd-boot.consoleMode = "auto";
    efi.canTouchEfiVariables = true;
  };

  boot.initrd = {
    systemd.enable = true;
    # Don't need to enter password in emergency mode
    systemd.emergencyAccess = true;
  };

  # ---------------------------------------------
  # Filesystems
  services.gvfs.enable = true;

  # ---------------------------------------------
  # Nix
  system.stateVersion = "25.05";

  # ---------------------------------------------
  # Gnome

  # ---------------------------------------------
  # Networking
  networking.networkmanager.enable = true;
  services.avahi.enable = true;

  # oof: apparently wifi 6e just realllly really sucks:
  #
  # - https://discourse.nixos.org/t/intel-ax210-ap-mode/66087/9
  # - https://github.com/randomizedcoder/nixos
  # - https://github.com/randomizedcoder/nixos/blob/main/desktop/l2/hostapd-multi.nix#L2
  hardware.wirelessRegulatoryDatabase = true;

  # ---------------------------------------------
  # Environment
  environment.variables = {
    GSK_RENDERER = "ngl"; # https://nixos.wiki/wiki/GNOME#Blank_windows
    NIXOS_OZONE_WL = "1";
    EDITOR = "vim";
  };

  environment.sessionVariables = {
    # TODO: nixos: remove unnecessary reliance on $HOME/bin (use writeScriptBin)
    PATH = "$HOME/bin";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  # ---------------------------------------------
  # VS Code
  programs.vscode = {
    enable = true;
    defaultEditor = false;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      golang.go
      twxs.cmake
      ms-vscode.cpptools
      redhat.java
      redhat.vscode-yaml
      ms-python.python
      ms-python.debugpy
      ms-python.vscode-pylance
      ms-python.isort
      ms-python.black-formatter
      vscjava.vscode-java-pack
    ];
  };

  # ---------------------------------------------
  # Programs
  programs.foot.enable = true;
  programs.yazi.enable = true;
  programs.neovim.enable = true;

  programs.television = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };

  programs.starship = {
    enable = true;
    interactiveOnly = true; # default
  };

  programs.zsh = {
    enableCompletion = true;
    autosuggestions.enable = false;
    vteIntegration = false;
    ohMyZsh = {
      enable = true;
      theme = "avit";
    };
  };

  programs.git = {
    enable = true;
    prompt.enable = true;
    lfs.enable = true;
  };
  programs.firefox.enable = true;
  programs.thunar.enable = true;

  services.flatpak.enable = true;

  programs.mtr.enable = true;

  programs.tmux.enable = true;
  programs.tmux = {
    withUtempter = false; # /var/run/utmp (to display connected users)
    secureSocket = true; # socket in /run instead of /tmp (a little to forward)
    # tmuxPlugins.copycat, tmuxPlugins.fpp, tmuxPlugins.cpu, tmuxPlugins.cpu
    plugins = [ pkgs.tmuxPlugins.sessionist pkgs.tmuxPlugins.sysstat ];
    # defaults
    shortcut = "b"; # Screen "a"
  };
}
