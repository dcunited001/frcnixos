{ pkgs, ... }: {
  services.desktopManager.gnome.debug = true; # maybe turn off
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # defaults
  services.gnome = {
    core-shell.enable = true;
    core-apps.enable = true;
    # dconf-editor, devhelp, gnome-builder, sysprof
    core-developer-tools.enable = true;

    glib-networking.enable = true;

    # search indexing
    localsearch.enable = false;
    tinysparql.enable = false;

    sushi.enable = true; # file previewer for nautilus

    # initial setup
    gnome-initial-setup.enable = true;

    # keyring
    gnome-keyring.enable = true;

    # accessibility
    at-spi2-core.enable = false;
  };

  # used by Gnome 3 for thunderbolt settings
  services.hardware.bolt.enable = true;
  qt.platformTheme = "gnome";
}
