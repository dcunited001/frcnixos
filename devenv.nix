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
    # pkgs.yq-go
    pkgs.yq
    # pkgs.tomlq

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

      # target.host = "root@theiainstall";
      target.host = "root@theiadeploy";
      target.sshOpts = [
        "-F"
        ".ssh/config"
        "-o"
        "IdentitiesOnly=yes"
      ];
      install.copyHostKeys = true;

      # TODO gen pubkey via just (not secretspec), move to nix/machines/theia
      # TODO this should really not go here
      # install.extraFiles."/root/.ssh/authorized_keys".source = "nix/machines/deploy.ed25519.pub";

      # install.extraFiles."/root/.ssh/authorized_keys" = {
      #   source = "nix/machines/deploy.ed25519.pub";
      #   mode = "0644";
      #   owner = "0:0";
      # };

      # install.secrets = {
      #   "/var/lib/sops-nix/key.123.txt" = {
      #     secret = "FOOBAR_AGE_KEY";
      #     owner = "0:0";
      #     mode = "0600";
      #   }
      # }

      nixos = {
        # _module.args.rk3588 = { # (vendor)
        #   inherit (inputs) nixpkgs;
        #   inherit pkgsKernel;
        # };
        imports = [
          # inputs.nixos-rk3588.nixosModules.boards.orangepi5plus.core # (vendor)
          ./nix/machines/serial.nix
          ./nix/machines/ssh.nix
          ./nix/machines/tools.nix

          ./nix/machines/theia/kernel.nix
          ./nix/machines/theia/boot.nix
          # ./nix/machines/theia/boot-vendor.nix # (vendor)
          ./nix/machines/theia/disko.nix
          ./nix/machines/theia/net.nix
          ./nix/machines/theia/ssh.nix
          ./nix/machines/theia/term.nix
          ./nix/machines/users/dc.nix
          ./nix/machines/users/users.nix
        ];
        services.openssh.enable = true;
        users.users.root.openssh.authorizedKeys.keyFiles = [
          ./nix/machines/deploy.ed25519.pub
          ./nix/machines/install.ed25519.pub
        ];
      };
    };
  };
}
# Config:1 ends here
