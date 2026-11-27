# [[file:../../README.org::*Basic Tools][Basic Tools:1]]
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    lm_sensors

    mtdutils
    i2c-tools
    
    # no gui yet
    # emacs
    # neovim

    vim
    btop
    tmux
    minicom
    screen
    gnumake
    gdb

    ripgrep
    fd

    parted
    cryptsetup
    btrfs-progs
    btrfs-list

    p7zip
    unzip
    # diskonaut-ng

    tree
    # nixd
    # nh
    # nixfmt
    jq
    yq
    jc
    sqlite

    socat

    pass
    # age
    # age-plugin-yubikey
    # age-plugin-tpm
    # agenix-cli
    sops

    # pgpdump
    yubikey-manager
    yubikey-personalization
    yubico-piv-tool
    ent
    pwgen
    rng-tools
    cfssl
    pcsc-tools
  ];
}
# Basic Tools:1 ends here
