# [[file:../../../README.org::*Config][Config:1]]
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pgpdump
    parted
    cryptsetup

    yubikey-manager
    yubikey-personalization
    yubico-piv-tool

    # Testing
    ent
    pwgen
    rng-tools

    cfssl
    pcsc-tools
    tmux
    htop

    btrfs-progs
    btrfs-list

    tree
    emacs
    neovim
    vim
    nixd
    # nh
    nixfmt
    vim
    jq
    yq
    jc
    sqlite
    gnumake
    tmux
    screen
    ripgrep
    fd
    pass
    age
    age-plugin-yubikey
    age-plugin-tpm
    agenix-cli
    sops
    p7zip
    unzip
    socat
  ];
}
# Config:1 ends here
