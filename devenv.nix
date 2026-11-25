# [[file:README.org::*Config][Config:1]]
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://github.com/meillaya/kernscope/blob/1c69ae251e3c22c3189d8a2e04cc5b15ea8624c6/devenv.nix

  # https://devenv.sh/packages
  packages = [
    pkgs.git
    pkgs.just
    pkgs.pkg-config
    pkgs.libxml2
    pkgs.jq
    pkgs.yq
    pkgs.tomlq

    pkgs.minicom
    pkgs.secretspec
  ];
  # languages.python.enable = true;
  #   languages.python = {
  # }

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";

  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # git-hooks.hooks = {
  #   clippy = {
  #     enable = true;
  #     settings.offline = false;
  #     extraPackages = [ pkgs.openssl ];
  #   };
  # };
  # git-hooks.settings.rust.cargoManifestPath = "./Cargo.toml";

  machines = {
    theia = let
      targetSystem = "aarch64-linux";
      pkgsKernel = import inputs.nixpkgs { system = targetSystem; };
    in {
      system = targetSystem;
      specialArgs.rk3588 = {
        inherit (inputs) nixpkgs;
        inherit pkgsKernel;
      };

      target.host = "root@theia";
      target.sshOpts = [
        "-o"
        "IdentitiesOnly=yes"
      ];
      nixos = {
        _module.args.rk3588 = { inherit (inputs) nixpkgs; inherit pkgsKernel; };
        imports = [
          inputs.nixos-rk3588.nixosModules.boards.orangepi5plus.core
          ./nix/machines/serial.nix
          ./nix/machines/ssh.nix
          ./nix/machines/tools.nix

          ./nix/machines/theia/disko.nix
          ./nix/machines/theia/net.nix
          ./nix/machines/theia/ssh.nix
          ./nix/machines/theia/term.nix
        ];
      };
      services.openssh.enable = true;
      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgQVDli1owQsEXoQ/94sp8Dm87S4mONeBf5DArT/V+i"
      ];
    };
    theia-install = {
      system = "aarch64-linux";
      target.host = "root@theia";
      target.sshOpts = [
        "-o"
        "IdentitiesOnly=yes"
      ];
      # [ "-o" "UserKnownHostsFile=/absolute/path" ];
      nixos = import ./nix/machines/theia/installer.nix;
      users.users.root.openssh.authorizedKeys.keys = lib.mkForce [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1KSX/0Kcoc70rGum3bLz9jXtscpOaV1KNarQ24jPR+"
      ];
    };
  };
}
# Config:1 ends here
