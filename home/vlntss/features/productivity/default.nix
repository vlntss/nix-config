{pkgs, ...}: {
  imports = [
    ./bitwarden.nix
    ./firefox.nix
    ./obsidian.nix
  ];
}
