{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    defaultEditor = false;
    package = pkgs.vscode.fhsWithPackages
      (ps: with ps; [ stdenv.cc.cc.lib zlib openssl.dev pkg-config ]);
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

  # This is a fix to enable VSCode to successfully remote SSH on a client to a NixOS host
  # https://wiki.nixos.org/wiki/Visual_Studio_Code # Remote_SSH
  programs.nix-ld.enable = true;

  # needed for store VS Code auth token
  services.gnome.gnome-keyring.enable = true;
}
