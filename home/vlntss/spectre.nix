{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager users and all sit within
    # the cli subfolder..
    ./global
    # Import my features for the user on this host. This can
    # either be the folder itself (all contents imported via
    # the included default.nix) or individual nix files wihin
    # each feature subfolder if I want to be selective.
    ./features/comms
    ./features/development/vscodium.nix
    ./features/gaming
    ./features/media/spicetify.nix
    ./features/productivity
    ./features/services
    # Import my desktop/window manager/compositor.
    ./features/desktop/cosmic
  ];
}
