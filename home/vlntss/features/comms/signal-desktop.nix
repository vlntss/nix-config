{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    signal-desktop
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/Signal"
    ];
    files = [
    ];
  };
}
