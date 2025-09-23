{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.persistence."/persist" = {
    directories = [
      ".config/cosmic"
    ];
    files = [
    ];
  };
}
