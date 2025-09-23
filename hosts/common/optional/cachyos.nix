{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
}
