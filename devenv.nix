{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  foo = "bar";
in
{
  # https://github.com/meillaya/kernscope/blob/1c69ae251e3c22c3189d8a2e04cc5b15ea8624c6/devenv.nix

  # https://devenv.sh/packages
  packages = [
    pkgs.git
    pkgs.just
    pkgs.pkg-config
    pkgs.libxml2
    pkgs.jq
    pkgs.yq

    pkgs.minicom
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
    hello         # Run scripts directly
    git --version # Use packages
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
    theia = {
      system = "aarch64-linux";
      target.host = "theia";
      nixos = import ./nix/machines/theia/server.nix;
    };
  };
}
